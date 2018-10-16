//
//  LightsTableViewController.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 10/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import WikiSDK

class LightsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Wiki.Controllers.LightsController.TITLE
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if AppDelegate.house.ledCount() > 0 {
            return AppDelegate.house.ledCount()
        } else {
            return 0
        }
    }
    
    private func getLedAt(indexPath: IndexPath) -> Led {
        return AppDelegate.house.getLedAtPosition(indexPath.row)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Wiki.Controllers.LightsController.CELL_REUSE_IDENTIFIER, for: indexPath)

        // Configure the cell...
        if let ledCell = cell as? LightTableViewCell {
            ledCell.led = getLedAt(indexPath: indexPath)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.house.removeLedAt(indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func download(_ sender: UIBarButtonItem) {
        showAlertViewWithTitle("DA FARE", andMessage: "bottone download premuto")
    }
    
    @IBAction func upload(_ sender: UIBarButtonItem) {
        showAlertViewWithTitle("DA FARE", andMessage: "bottone upload premuto")
    }
    
    private func showAlertViewWithTitle(_ title: String, andMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addLight(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Nuovo Accessorio", message: "Inserisci nome nuovo accessorio", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Inserisci", style: .default) { (_) in
            if let name = alertController.textFields?[0].text,
                let key = alertController.textFields?[1].text,
                let position = alertController.textFields?[2].text {
                let response = AppDelegate.house.addLed(Led(name: name, key: key, position: Int(position) ?? -1))
                if !response {
                    // notify the error
                    let alertController2 = UIAlertController(title: "Attenzione", message: "Accessorio già aggiunto", preferredStyle: .alert)
                    alertController2.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController2, animated: true, completion: nil)
                }
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancella", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Inserisci il nome"
        }
        alertController.addTextField { textfield in
            textfield.placeholder = "Inserisci chiave"
        }
        alertController.addTextField { textfield in
            textfield.placeholder = "Inserisci posizione"
            textfield.keyboardType = UIKeyboardType.decimalPad
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}
