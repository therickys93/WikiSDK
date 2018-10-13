//
//  ViewController.swift
//  WikiSDK
//
//  Created by therickys93 on 10/08/2018.
//  Copyright (c) 2018 therickys93. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var wikiControllerServerTextField: UITextField!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lightPickerView: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    private func updateStaticUI(){
        self.title = Wiki.Controllers.WikiController.TITLE
        self.wikiControllerServerTextField.text = Wiki.Controllers.WikiController.DEFAULT_URL
        self.versionLabel.text = "Versione applicazione: \(Bundle.main.releaseVersionNumber).\(Bundle.main.buildVersionNumber)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateStaticUI()
        self.lightPickerView.delegate = self
        self.lightPickerView.dataSource = self
        self.pickerData = AppDelegate.leds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pickerData.removeAll()
        self.pickerData = AppDelegate.leds
        self.lightPickerView.reloadAllComponents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        showAlertViewWithTitle("DA FARE", andMessage: "bottone accendi premuto")
    }
    
    @IBAction func switchOff(_ sender: UIButton) {
        showAlertViewWithTitle("DA FARE", andMessage: "bottone spegni premuto")
    }
    
    @IBAction func open(_ sender: UIButton) {
        showAlertViewWithTitle("DA FARE", andMessage: "bottone apri premuto")
    }
    
    @IBAction func close(_ sender: UIButton) {
        showAlertViewWithTitle("DA FARE", andMessage: "bottone chiudi premuto")
    }
    
    @IBAction func status(_ sender: UIButton) {
        showAlertViewWithTitle("DA FARE", andMessage: "bottone stato premuto")
    }
    
    @IBAction func reset(_ sender: UIButton) {
        showAlertViewWithTitle("DA FARE", andMessage: "bottone reset premuto")
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
