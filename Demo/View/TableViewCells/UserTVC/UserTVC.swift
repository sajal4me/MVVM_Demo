//
//  UserTVC.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import UIKit

final class UserTVC: UITableViewCell {
    
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var email: UILabel!
    @IBOutlet private weak var message: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func populateCell(_ viewModel: UserViewModel) {
        name.text = viewModel.fullName
        email.text = viewModel.email
        message.text = viewModel.message
    }
    
}
