//
//  MacroTableViewCell.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 1/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class MacroTableViewCell: UITableViewCell {
    @IBOutlet weak var macroName: UILabel!
    
    var name: String? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        self.macroName.text = name
    }
        
}
