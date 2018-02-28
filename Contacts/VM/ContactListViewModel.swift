//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by Игорь on 25.02.2018.
//  Copyright © 2018 igor. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

typealias ContactsBySubstr = (substr:String, contacts:[ContactEntity])

class ContactListViewModel {
    let api:ContactAPI
    let contactsModels:Observable<(query:String, models:[SectionModel<String, ContactEntity>])>
    init(inputs:(searchTextChanged:Observable<String>, contactSelected:Observable<IndexPath>), API:ContactAPI) {
        self.api = API
        let digitSet = CharacterSet.decimalDigits
        contactsModels = inputs.searchTextChanged.throttle(0.5, scheduler: MainScheduler.instance).distinctUntilChanged().observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated)).flatMapLatest { (query) in
            return Observable.zip(Observable.of(query), API.getContacts(bySubstring: query)) {(substr:$0, contacts: $1)}
            }.map({ (res) -> (query:String, items: [ContactsBySubstr]) in
                
                if res.substr == ""{
                    var dict:[String:[ContactEntity]] = [:]
                    for contact in res.contacts{
                        if let firstChar = contact.lastName?.first{
                          
                            var firstLetter = String(firstChar)
                            if digitSet.contains(firstLetter.unicodeScalars.first!) {
                                firstLetter = "#"
                            }
                            dict[String(firstLetter)] = dict[String(firstLetter)] == nil ? [contact] : dict[String(firstLetter)]! + [contact]
                        }
                    }
                    return (query: res.substr, items: dict.sorted {$0.key < $1.key}.map { (substr:$0, contacts: $1)})
                    
                }else{
                    return (query: res.substr, items: [res])
                }
            }).map({ (res) -> (query:String, models:[SectionModel<String, ContactEntity>]) in
                let items = res.items.map({ (item) in
                    return SectionModel(model: item.substr, items: item.contacts)
                })
                return (query:res.query, models:items)
            }).observeOn(MainScheduler.instance).share(replay: 1)
    }
    
    
}


