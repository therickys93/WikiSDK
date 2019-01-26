//
//  MacroTableViewController.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 1/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WikiSDK

class MacroTableViewController: UITableViewController {

    private var macros = [Macro]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Macro"
        self.macros = Utils.readMacro(file: Wiki.Constants.MACROFILE)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Utils.saveMacros(self.macros, inFile: Wiki.Constants.MACROFILE)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return macros.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MacroIdentifier", for: indexPath)
        
        // Configure the cell...
        if let macroCell = cell as? MacroTableViewCell {
            macroCell.macro = macros[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.macros.remove(at: indexPath.row)
            Utils.saveMacros(self.macros, inFile: Wiki.Constants.MACROFILE)
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Macro Segue" {
            if let _ = sender as? UIBarButtonItem {
                // from the plus button
                if let emvc = segue.destination.contents as? EditMacroViewController {
                    let newMacro = Macro(name: "", sendable: [])
                    self.macros.append(newMacro)
                    emvc.macro = newMacro
                    emvc.title = "Nuova Macro"
                }
            } else if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                if let emvc = segue.destination.contents as? EditMacroViewController {
                    emvc.macro = macros[indexPath.row]
                    emvc.title = "Modifica Macro"
                }
            }
        }
    }

}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
