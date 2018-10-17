//
//  LightTableViewCell.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 10/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import WikiSDK

class LightTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    var led: Led? { didSet { updateUI() } }
    
    private func updateUI() {
        self.nameLabel.text = led?.name
        self.keyLabel.text = "chiave: \(led?.key ?? "")"
        self.positionLabel.text = "#\(led?.position ?? -1)"
    }
    
}
