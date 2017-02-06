//
//  Person.swift
//  SaveToArchive
//
//  Created by Khuất Dũng on 2/6/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import os.log
import UIKit

class Person : NSObject {
    var name: String
    var phone: Int?
    
    struct PropertyKey {
        static let name = "name"
        static let phone = "phone"
    }
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("person")
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a People object.", log: OSLog.default, type: .debug)
            return nil
        }
        let phone = aDecoder.decodeInteger(forKey: PropertyKey.phone)
        self.init(name: name, phone: phone)
  
    }
 
    
    //Mark: Initialization
    init?(name: String, phone: Int) {
        guard !name.isEmpty else {
            return nil
        }
      
        //Initialize stored properties
        self.name = name
        self.phone = phone
    }

}
