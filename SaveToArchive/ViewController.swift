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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (nameTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)! {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (nameTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)! {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
            textField.resignFirstResponder()
        }
        return true
    }
    //MARK: Navigation
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
}

