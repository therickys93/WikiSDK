//
//  LightsTableViewController.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 10/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class LightsTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Configura Casa"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.leds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = AppDelegate.leds[indexPath.row]

        return cell
    }
    
    @IBAction func addLight(_ sender: UIBarButtonItem) {
        AppDelegate.leds.append("Accessorio 5")
        self.tableView.reloadData()
    }
    

}
