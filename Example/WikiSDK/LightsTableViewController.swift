//
//  LightsTableViewController.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 10/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class LightsTableViewController: UITableViewController {

    private var leds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Configura Casa"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.leds = AppDelegate.leds
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.leds.count > 0 {
            return self.leds.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = AppDelegate.leds[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.leds.remove(at: indexPath.row)
            self.leds = AppDelegate.leds
            Utils.writeContent(AppDelegate.leds.joined(separator: "\n"), toFile: "pippo.txt")
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func addLight(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Nuovo Accessorio", message: "Inserisci nome nuovo accessorio", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Inserisci", style: .default) { (_) in
            if let name = alertController.textFields?[0].text {
                AppDelegate.leds.append(name)
                self.leds = AppDelegate.leds
                Utils.writeContent(AppDelegate.leds.joined(separator: "\n"), toFile: "pippo.txt")
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancella", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Inserisci il nome"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}
