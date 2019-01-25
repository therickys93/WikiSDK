//
//  MacroTableViewCell.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 1/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WikiSDK

class MacroTableViewCell: UITableViewCell {
    @IBOutlet weak var macroName: UILabel!
    @IBOutlet weak var buttonMacro: UIButton!
    private var activityIndicator = UIActivityIndicatorView()
    
    var macro: Macro? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        self.macroName.text = macro?.name
    }
        
    @IBAction func runMacro(_ sender: UIButton) {
        let server = Utils.loadWikiControllerURL()
        if let commands = macro?.sendable {
            
            self.buttonMacro.setTitle("...", for: .normal)

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
                    self?.buttonMacro.setTitle("Avvia", for: .normal)
                }
            }
        }
    }
    
    // var activityIndicator = UIActivityIndicatorView()
    // var strLabel = UILabel()
    //
    // let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // private func playIndicator(_ title: String) {
    //     strLabel.removeFromSuperview()
    //     activityIndicator.removeFromSuperview()
    //     effectView.removeFromSuperview()
    //
    //     strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
    //     strLabel.text = title
    //     strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
    //     strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
    //
    //     effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
    //     effectView.layer.cornerRadius = 15
    //     effectView.layer.masksToBounds = true
    //
    //     activityIndicator = UIActivityIndicatorView(style: .white)
    //     activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
    //     activityIndicator.startAnimating()
    //
    //     effectView.contentView.addSubview(activityIndicator)
    //     effectView.contentView.addSubview(strLabel)
    //     view.addSubview(effectView)
    // }

}

extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
