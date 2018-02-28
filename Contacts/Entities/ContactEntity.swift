//
//  ContactEntity.swift
//  Contacts
//
//  Created by Игорь on 25.02.2018.
//  Copyright © 2018 igor. All rights reserved.
//

import Foundation
class ContactEntity {
    var firstName:String?
    var lastName:String?
    var company:String?
    var birthday:TimeInterval?
    var phones:[ContactPhoneEntity] = []
    
    var fullName:String?{
        get{
            return (firstName ?? "") + " " + (lastName ?? "")
        }
    }
    
    init(firstName:String, lastName:String){
        self.firstName = firstName
        self.lastName = lastName
    }
}
