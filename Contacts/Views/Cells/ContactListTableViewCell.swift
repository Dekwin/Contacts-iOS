//
//  ContactListTableViewCell.swift
//  Contacts
//
//  Created by Игорь on 25.02.2018.
//  Copyright © 2018 igor. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(withTitle title:String?){
        nameLabel.text = title
    }

}
