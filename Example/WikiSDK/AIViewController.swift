//
//  AIViewController.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 1/6/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

@available(iOS 10.0, *)
class AIViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var responseTextView: UITextView!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "it-IT"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        microphoneButton.isEnabled = false
        
        speechRecognizer.delegate = self as? SFSpeechRecognizerDelegate
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(normalTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        microphoneButton.addGestureRecognizer(tapGesture)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        microphoneButton.addGestureRecognizer(longGesture)
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
    }
    
    @objc func normalTap(_ sender: UIGestureRecognizer){
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            
            makeWikiServerRequest(self.textView.text) { [weak self] resultString in
                DispatchQueue.main.async {
                    self?.textToSpeech(resultString)
                    self?.responseTextView.text = resultString
                }
            }
            
            microphoneButton.isEnabled = false
            microphoneButton.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            microphoneButton.setTitle("Stop Recording", for: .normal)
        }
    }
    
    @objc func longTap(_ sender: UIGestureRecognizer){
        if sender.state == .ended {
            // do nothing here
        }
        else if sender.state == .began {
            // display the alertview
            // save the string
            // get the string to save
            let alertController = UIAlertController(title: "WikiServer URL", message: "Insert WikiServer URL", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Insert", style: .default) { (_) in
                if let url = alertController.textFields?[0].text {
                    // save the url
                    self.saveWikiServerURL(url)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            alertController.addTextField { (textField) in
                textField.placeholder = "Insert the URL"
                textField.text = self.loadWikiServerURL()
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    struct Defines {
        static let KEY = "KEY"
    }
    
    private func saveWikiServerURL(_ url: String) {
        UserDefaults.standard.set(url, forKey: Defines.KEY)
    }
    
    private func loadWikiServerURL() -> String {
        return UserDefaults.standard.string(forKey: Defines.KEY) ?? "http://192.168.15.15:8080/v1/wiki"
    }
    
    private func makeWikiServerRequest(_ request: String, completionHandler handler: @escaping (String) -> Void) {
        let json: [String: Any] = ["request": request]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: loadWikiServerURL())!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                handler("errore nella richiesta")
                return
            }
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else {
                return
            }
            let result = jsonResponse?["response"] as? String
            handler(result!)
        }
        task.resume()
    }
    
    @IBAction func microphoneTapped(_ sender: AnyObject) {
        // old button function
    }
    
    private func textToSpeech(_ toSay: String)
    {
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: toSay)
        utterance.voice = AVSpeechSynthesisVoice(language: "it-IT")
        synthesizer.speak(utterance)
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record, mode: .default, options: .defaultToSpeaker)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        /*
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        */
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.textView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textView.text = "Dimmi tutto, sto ascoltando!"
        
    }
    
    @available(iOS 10.0, *)
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }
    
}
