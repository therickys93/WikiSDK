//
//  ViewController.swift
//  WikiSDK
//
//  Created by therickys93 on 10/08/2018.
//  Copyright (c) 2018 therickys93. All rights reserved.
//

import UIKit
import WikiSDK

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var wikiControllerServerTextField: UITextField!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lightPickerView: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    private func updateStaticUI(){
        self.title = Wiki.Controllers.WikiController.TITLE
        self.wikiControllerServerTextField.text = Utils.loadWikiControllerURL()
        self.versionLabel.text = "Versione applicazione: \(Bundle.main.releaseVersionNumber).\(Bundle.main.buildVersionNumber)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateStaticUI()
        self.lightPickerView.delegate = self
        self.lightPickerView.dataSource = self
        self.wikiControllerServerTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            Utils.writeToLog("New WikiController URL: \(text)")
            Utils.saveWikiControllerURL(text)
        }
        return true
    }
    
    private func getAllAccessoriesNames() -> [String] {
        var names = [String]()
        for led in AppDelegate.house.led {
            names.append(led.name)
        }
        return names
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pickerData.removeAll()
        self.pickerData = getAllAccessoriesNames()
        self.lightPickerView.reloadAllComponents()
    }
    
    private func getLedFromPickerView() -> Led? {
        let name = self.pickerData[self.lightPickerView.selectedRow(inComponent: 0)]
        return AppDelegate.house.getLedByName(name)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.pickerData.count > 0 {
            return self.pickerData.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.pickerData.count > 0 {
            return self.pickerData[row]
        } else {
            Utils.writeToLog("No Lights found")
            return Wiki.Constants.NO_LIGHTS_FOUND
        }
    }
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private func activityIndicator(_ title: String) {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    @IBAction func switchOn(_ sender: UIButton) {
        // if let server = self.wikiControllerServerTextField.text {
        //     let wikicontroller = WikiController(server: server)
        //     if let led = getLedFromPickerView() {
        //         wikicontroller.switchOn(led: led) { [weak self] response in
        //             DispatchQueue.main.async {
        //                 if response {
        //                     Utils.writeToLog("Switch on led: \(led.name) --> response OK")
        //                     self?.showToast(message: "OK")
        //                 } else {
        //                     Utils.writeToLog("Switch on led: \(led.name) --> response ERRORE")
        //                     self?.showToast(message: "ERRORE")
        //                 }
        //             }
        //         }
        //     }
        // }
        
        activityIndicator("macro...")
        
        var commands = [Sendable]()
        commands.append(On(key: "prova", position: 1))
        commands.append(On(key: "prova", position: 2))
        commands.append(On(key: "prova", position: 3))
        commands.append(On(key: "prova", position: 4))
        commands.append(On(key: "prova", position: 5))
        commands.append(On(key: "prova", position: 6))
        commands.append(On(key: "prova", position: 7))
        
        if let server = self.wikiControllerServerTextField.text {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else {
                    return
                }
                
                let wikicontroller = WikiController(server: server)
                for command in commands {
                    wikicontroller.execute(sendable: command, completionHandler: { response in
                        // do nothing here
                    })
                    sleep(1)
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.effectView.removeFromSuperview()
                    self?.showToast(message: "ok")
                }
            }
        }
    }
    
    @IBAction func switchOff(_ sender: UIButton) {
        // if let server = self.wikiControllerServerTextField.text {
        //     let wikicontroller = WikiController(server: server)
        //     if let led = getLedFromPickerView() {
        //         wikicontroller.switchOff(led: led) { [weak self] response in
        //             DispatchQueue.main.async {
        //                 if response {
        //                     Utils.writeToLog("Switch off led: \(led.name) --> response OK")
        //                     self?.showToast(message: "OK")
        //                 } else {
        //                     Utils.writeToLog("Switch off led: \(led.name) --> response ERROR")
        //                     self?.showToast(message: "ERRORE")
        //                 }
        //             }
        //         }
        //     }
        // }
        
        activityIndicator("macro...")
        
        var commands = [Sendable]()
        commands.append(Off(key: "prova", position: 1))
        commands.append(Off(key: "prova", position: 2))
        commands.append(Off(key: "prova", position: 3))
        commands.append(Off(key: "prova", position: 4))
        commands.append(Off(key: "prova", position: 5))
        commands.append(Off(key: "prova", position: 6))
        commands.append(Off(key: "prova", position: 7))
        
        if let server = self.wikiControllerServerTextField.text {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else {
                    return
                }
                
                let wikicontroller = WikiController(server: server)
                for command in commands {
                    wikicontroller.execute(sendable: command, completionHandler: { response in
                        // do nothing here
                    })
                    sleep(1)
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.effectView.removeFromSuperview()
                    self?.showToast(message: "ok")
                }
            }
        }
    }
    
    @IBAction func open(_ sender: UIButton) {
        if let server = self.wikiControllerServerTextField.text {
            let wikicontroller = WikiController(server: server)
            if let led = getLedFromPickerView() {
                wikicontroller.openClose(led: led) { [weak self] response in
                    DispatchQueue.main.async {
                        if response {
                            Utils.writeToLog("Open led: \(led.name) --> response OK")
                            self?.showToast(message: "OK")
                        } else {
                            Utils.writeToLog("Open led: \(led.name) --> response ERRORE")
                            self?.showToast(message: "ERRORE")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        if let server = self.wikiControllerServerTextField.text {
            let wikicontroller = WikiController(server: server)
            if let led = getLedFromPickerView() {
                wikicontroller.openClose(led: led) { [weak self] response in
                    DispatchQueue.main.async {
                        if response {
                            Utils.writeToLog("Close led: \(led.name) --> response OK")
                            self?.showToast(message: "OK")
                        } else {
                            Utils.writeToLog("Close led: \(led.name) --> response ERRORE")
                            self?.showToast(message: "ERRORE")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func status(_ sender: UIButton) {
        if let server = self.wikiControllerServerTextField.text {
            let wikicontroller = WikiController(server: server)
            if let led = getLedFromPickerView() {
                wikicontroller.status(key: led.key) { [weak self] response in
                    DispatchQueue.main.async {
                        Utils.writeToLog("Status led: \(led.name) --> response \(response)")
                        self?.showToast(message: response)
                    }
                }
            }
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        if let server = self.wikiControllerServerTextField.text {
            let wikicontroller = WikiController(server: server)
            if let led = getLedFromPickerView() {
                wikicontroller.reset(key: led.key) { [weak self] response in
                    DispatchQueue.main.async {
                        if response {
                            Utils.writeToLog("Reset key: \(led.key) --> response OK")
                            self?.showToast(message: "OK")
                        } else {
                            Utils.writeToLog("Reset key: \(led.key) --> response ERRORE")
                            self?.showToast(message: "ERRORE")
                        }
                    }
                }
            }
        }
    }
    
    
    private func showAlertViewWithTitle(_ title: String, andMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension Bundle {
    var releaseVersionNumber: String {
        if let release = infoDictionary?["CFBundleShortVersionString"] as? String {
            return release
        } else {
            return "0.0"
        }
    }
    var buildVersionNumber: String {
        if let build = infoDictionary?["CFBundleVersion"] as? String {
            return build
        } else {
            return "0"
        }
    }
}

extension UIViewController {
    
    func showToast(message: String) {
        
        let toastLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height-100, width: self.view.frame.size.width, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
