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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            return Wiki.Constants.NO_LIGHTS_FOUND
        }
    }
    
    @IBAction func switchOn(_ sender: UIButton) {
        if let server = self.wikiControllerServerTextField.text {
            let wikicontroller = WikiController(server: server)
            if let led = getLedFromPickerView() {
                wikicontroller.switchOn(led: led) { [weak self] response in
                    DispatchQueue.main.async {
                        if response {
                            self?.showToast(message: "OK")
                        } else {
                            self?.showToast(message: "ERRORE")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func switchOff(_ sender: UIButton) {
        if let server = self.wikiControllerServerTextField.text {
            let wikicontroller = WikiController(server: server)
            if let led = getLedFromPickerView() {
                wikicontroller.switchOff(led: led) { [weak self] response in
                    DispatchQueue.main.async {
                        if response {
                            self?.showToast(message: "OK")
                        } else {
                            self?.showToast(message: "ERRORE")
                        }
                    }
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
                            self?.showToast(message: "OK")
                        } else {
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
                            self?.showToast(message: "OK")
                        } else {
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
                            self?.showToast(message: "OK")
                        } else {
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
