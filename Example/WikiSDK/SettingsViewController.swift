//
//  SettingsViewController.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 6/29/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var appIDTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var fieldTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appIDTextField.delegate = self
        self.urlTextField.delegate = self
        self.classNameTextField.delegate = self
        self.fieldTextField.delegate = self

        // Do any additional setup after loading the view.
        self.title = Wiki.Controllers.Settings.TITLE
        self.appIDTextField.text = Utils.loadParseAppId()
        self.urlTextField.text = Utils.loadParseURL()
        self.classNameTextField.text = Utils.loadParseClassName()
        self.fieldTextField.text = Utils.loadParseField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if appIDTextField == textField {
            Utils.writeToLog("Parse appID: \(textField.text!)")
            Utils.saveParseAppId(textField.text!)
        }
        if urlTextField == textField {
            Utils.writeToLog("Parse URL: \(textField.text!)")
            Utils.saveParseURL(textField.text!)
        }
        if classNameTextField == textField {
            Utils.writeToLog("Parse ClassName: \(textField.text!)")
            Utils.saveParseClassName(textField.text!)
        }
        if fieldTextField == textField {
            Utils.writeToLog("Parse Field: \(textField.text!)")
            Utils.saveParseField(textField.text!)
        }
        return true
    }
    
}
