//
//  ContactAPILocalImpl.swift
//  Contacts
//
//  Created by Игорь on 27.02.2018.
//  Copyright © 2018 igor. All rights reserved.
//

import Foundation
import RxSwift
/**
    Stub class. Provides data for testing
 */
class ContactAPILocalImplTest: ContactAPI {
    static let shared:ContactAPI = ContactAPILocalImplTest()
    
    private let contactsArray:[ContactEntity] = [ContactEntity(firstName: "Bdsdds", lastName: "FFg"), ContactEntity(firstName: "Apple", lastName: "Hjhjhj"), ContactEntity(firstName: "23", lastName: "56"), ContactEntity(firstName: "Lol", lastName: "Annor")]
    
    func getContacts(bySubstring substring:String) -> Observable<[ContactEntity]> {
        let list:[ContactEntity] = substring == "" ? contactsArray : contactsArray.filter { (contact) -> Bool in
            return contact.fullName?.contains(substring) ?? false
            
        }
        
        return Observable.from(optional: list)
    }
    
    func getContacts(byFirstLetter letter:String) ->  Observable<[ContactEntity]> {
       // let list:[ContactsBySubstr] = [(substr:"B", contacts:[ContactEntity(firstName: "Bkjk", lastName: "Bjds")])]
        let list:[ContactEntity] = contactsArray
        return Observable.from(optional: list)
    }
    
}
