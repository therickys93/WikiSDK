//
//  EditMacroViewController.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 1/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WikiSDK

class EditMacroViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var macroNameTextField: UITextField! {
        didSet {
            self.macroNameTextField.delegate = self
        }
    }
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    var macro: Macro? {
        didSet {
            updateUI()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.text?.isEmpty)! {
            return false
        }
        if textField == self.macroNameTextField {
            if let text = self.macroNameTextField.text {
                self.macro?.name = text
            }
        }
        return true
    }
    
    private var pickerData = [String]()
    private let pickerActions = ["accendi", "spegni", "apri", "chiudi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    private func getAllAccessoriesNames() -> [String] {
        var names = [String]()
        for led in AppDelegate.house.led {
            names.append(led.name)
        }
        return names
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.pickerData.removeAll()
        self.pickerData = getAllAccessoriesNames()
        self.pickerView.reloadAllComponents()
    }
    
    private func updateUI() {
        self.macroNameTextField?.text = macro?.name
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // ListAction
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.macro?.sendable.count {
            tableView.separatorStyle = .singleLine
            return count
        } else {
            tableView.separatorStyle = .none
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListAction", for: indexPath)
        if let type = self.macro?.sendable[indexPath.row].type, let name = self.macro?.sendable[indexPath.row].led?.name {
            cell.textLabel?.text = "\(type) \(name)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.macro?.sendable.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.pickerActions.count
        } else if component == 1{
            return self.pickerData.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.pickerActions[row]
        } else if component == 1 {
            if self.pickerData.count > 0 {
                return self.pickerData[row]
            } else {
                return Wiki.Constants.NO_LIGHTS_FOUND
            }
        } else {
            return nil
        }
    }
    
    private func getLedFromPickerView() -> Led? {
        let name = self.pickerData[self.pickerView.selectedRow(inComponent: 1)]
        return AppDelegate.house.getLedByName(name)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        if let led = getLedFromPickerView() {
            let action = self.pickerActions[self.pickerView.selectedRow(inComponent: 0)]
            switch action {
            case "accendi":
                self.macro?.sendable.append(On(led: led))
                break
            case "spegni":
                self.macro?.sendable.append(Off(led: led))
                break
            case "apri":
                self.macro?.sendable.append(OpenClose(led: led))
                break
            case "chiudi":
                self.macro?.sendable.append(OpenClose(led: led))
                break
            default:
                break
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        // save the macro
        if let text = self.macroNameTextField.text {
            self.macro?.name = text
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
