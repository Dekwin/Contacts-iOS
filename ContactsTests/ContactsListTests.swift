//
//  ContactsListTests.swift
//  ContactsTests
//
//  Created by Игорь on 01.03.2018.
//  Copyright © 2018 igor. All rights reserved.
//

import XCTest
import RxSwift
@testable import Contacts
class ContactsListTests: XCTestCase {
    
    var api: ContactAPI!
    var disposeBag:DisposeBag!
    override func setUp() {
        super.setUp()
        api = ContactAPILocalImplTest()
        disposeBag = DisposeBag()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        api = nil
        disposeBag = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewModelItemsCount() {
        let searchTextSubj = PublishSubject<String>()
        let contactSelectedSubj = PublishSubject<IndexPath>()
        
        let vm = ContactListViewModel(inputs: (searchTextChanged: searchTextSubj.asObservable(), contactSelected: contactSelectedSubj.asObservable()), API: api)
        
        let expectation1 = expectation(description: "API Request Complete")
        
        vm.contactsModels.subscribe(onNext: { (res) in
            let modelsCount = res.models.count
            let expectedModelsCount = 1
            let result1 = expectedModelsCount == modelsCount
            XCTAssertTrue(result1, "Wrong models count, must be \(expectedModelsCount)")
            let itemsInFirstModelCount = res.models[0].items.count
            let minExpectedItemsInFirstModelCount = 1
            let result2 = itemsInFirstModelCount >= minExpectedItemsInFirstModelCount
            XCTAssertTrue(result2, "Wrong items count, must be >= \(minExpectedItemsInFirstModelCount)")
            
            expectation1.fulfill()
        }, onError: { (error) in
            XCTFail("On error")
        }, onCompleted: {
        }) {
        }.disposed(by: disposeBag)
        
        searchTextSubj.onNext("A")
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
