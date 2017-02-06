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

class Person :NSObject,NSCoding {
    var name: String
    var phone: String
    
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
        guard let phone = aDecoder.decodeObject(forKey: PropertyKey.phone) as? String else {
            os_log("Unable to decode the phone number for a People object.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(name: name, phone: phone)
  
    }
 
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(phone, forKey: PropertyKey.phone)
    }
    //Mark: Initialization
    init?(name: String, phone: String) {
        guard !name.isEmpty || !phone.isEmpty else {
            return nil
        }
      
        //Initialize stored properties
        self.name = name
        self.phone = phone
    }

}
