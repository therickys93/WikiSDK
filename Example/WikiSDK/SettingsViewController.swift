//
//  SettingsViewController.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 6/29/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var appIDTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var fieldTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = Wiki.Controllers.Settings.TITLE
        self.appIDTextField.text = Utils.loadParseAppId()
        self.urlTextField.text = Utils.loadParseURL()
        self.classNameTextField.text = Utils.loadParseClassName()
        self.fieldTextField.text = Utils.loadParseField()
    }
    
}
