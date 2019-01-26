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
        
        // init macro accendi tutto
        var commands = [Sendable]()
        commands.append(On(led: Led(name: "luce camera", key: "prova", position: 1)))
        commands.append(On(led: Led(name: "luce bagno", key: "prova", position: 2)))
        commands.append(On(led: Led(name: "luce cameretta", key: "prova", position: 3)))
        commands.append(On(led: Led(name: "luce cucina", key: "prova", position: 4)))
        commands.append(On(led: Led(name: "luce salotto", key: "prova", position: 5)))
        commands.append(On(led: Led(name: "luce bottega", key: "prova", position: 6)))
        commands.append(On(led: Led(name: "luce garage", key: "prova", position: 7)))
        macros.append(Macro(name: "accendi tutto", sendable: commands))
        var test = Macro.createStringFromMacros(macros)
        // var response = Macro.createMacrosFromString(test)
        print("\(test)")
        
        // init macro spegni tutto
        var commands2 = [Sendable]()
        commands2.append(Off(led: Led(name: "luce camera", key: "prova", position: 1)))
        commands2.append(Off(led: Led(name: "luce bagno", key: "prova", position: 2)))
        commands2.append(Off(led: Led(name: "luce cameretta", key: "prova", position: 3)))
        commands2.append(Off(led: Led(name: "luce cucina", key: "prova", position: 4)))
        commands2.append(Off(led: Led(name: "luce salotto", key: "prova", position: 5)))
        commands2.append(Off(led: Led(name: "luce bottega", key: "prova", position: 6)))
        commands2.append(Off(led: Led(name: "luce garage", key: "prova", position: 7)))
        macros.append(Macro(name: "spegni tutto", sendable: commands2))
        test = Macro.createStringFromMacros(macros)
        print("\(test)")
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
                    emvc.title = "New Macro"
                }
            } else if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                if let emvc = segue.destination.contents as? EditMacroViewController {
                    emvc.macro = macros[indexPath.row]
                    emvc.title = "Edit Macro"
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
