//
//  ViewController.swift
//  SaveToArchive
//
//  Created by Khuất Dũng on 2/6/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
   
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var person: Person?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        phoneTextField.delegate = self
        if let person = person {
            navigationItem.title = person.name
            nameTextField.text = person.name
            phoneTextField.text = "\(person.phone!)"
        }
        updateSaveButtonStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSaveButtonStatus()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       updateSaveButtonStatus()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //MARK: Navigation
   
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddPersonMode = presentingViewController is UINavigationController
        if isPresentingInAddPersonMode {
            dismiss(animated: true, completion: nil)
        } else if let ownigNavigationController = navigationController {
            ownigNavigationController.popViewController(animated: true)
        } else {
            fatalError("erorr")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        person = Person(name: name, phone: Int(phone)!)
    }
    
    //MARK: Private method
    private func updateSaveButtonStatus() {
        if (nameTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)! {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
}

