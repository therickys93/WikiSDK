//
//  EditMacroViewController.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 1/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class EditMacroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
