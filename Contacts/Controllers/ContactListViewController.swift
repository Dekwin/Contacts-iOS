//
//  ContactListViewController.swift
//  Contacts
//
//  Created by Игорь on 25.02.2018.
//  Copyright © 2018 igor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ContactListViewController: UIViewController {
    
    @IBOutlet weak var addContactButton: UIBarButtonItem!
    @IBOutlet weak var contactsTableView: UITableView!
    var disposeBag:DisposeBag = DisposeBag()
    var vm:ContactListViewModel?
    let searchController = UISearchController(searchResultsController: nil)
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ContactEntity>>(configureCell: { (v, tv, indexPath, element) in
        let cell = tv.dequeueReusableCell(withIdentifier: "ContactListCellId", for: indexPath) as! ContactListTableViewCell
        cell.update(withTitle: element.fullName)
        
        return cell
    },titleForHeaderInSection: { dataSource, sectionIndex in
        return dataSource[sectionIndex].model
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //after cancelButtonClicked text removes but rx.text shows previous value
        let merged = Observable.merge(searchController.searchBar.rx.cancelButtonClicked.asObservable().startWith(()).map({ (void) in
            return ""
        }), searchController.searchBar.rx.text.orEmpty.asObservable())
        
    
        
        let lastEvent = Observable.combineLatest(searchController.searchBar.rx.textDidEndEditing.asObservable().startWith(()),merged).map { (res) -> String in
            return res.1
        }.share(replay: 1)
        
        vm = ContactListViewModel(inputs: (searchTextChanged:lastEvent, contactSelected:contactsTableView.rx.itemSelected.asObservable()), API:ContactAPILocalImplTest.shared)
        setViews()
        setSubscriptions()
        
        
    }
    
    private func setSubscriptions(){
        let dataSource = self.dataSource
        vm?.contactsModels.map({ (res) -> [SectionModel<String, ContactEntity>] in
            
            return res.models
        }).bind(to: contactsTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        contactsTableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { pair in
                //go to contact
            })
            .disposed(by: disposeBag)
        
        contactsTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func setViews(){
        navigationItem.searchController = searchController
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "contact_list_title_contacts".localized()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ContactListViewController: UITableViewDelegate{
    // to prevent swipe to delete behavior
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
}
