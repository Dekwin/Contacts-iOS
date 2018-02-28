//
//  File.swift
//  Contacts
//
//  Created by Игорь on 27.02.2018.
//  Copyright © 2018 igor. All rights reserved.
//

import Foundation
import RxSwift



protocol ContactAPI {
    func getContacts(bySubstring substring:String) -> Observable<[ContactEntity]>
    
    func getContacts(byFirstLetter letter:String) ->  Observable<[ContactEntity]>
    
}
