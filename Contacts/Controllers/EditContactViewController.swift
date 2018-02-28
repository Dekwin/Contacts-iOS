//
//  EditContactViewController.swift
//  Contacts
//
//  Created by Игорь on 25.02.2018.
//  Copyright © 2018 igor. All rights reserved.
//

import UIKit

class EditContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        // Do any additional setup after loading the view.
    }
    
    private func setViews(){
        navigationItem.title = "edit_contact_title".localized()
        navigationItem.largeTitleDisplayMode = .never
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
