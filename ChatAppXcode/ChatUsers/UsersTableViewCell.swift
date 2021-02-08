//
//  UsersTableViewCell.swift
//  ChatAppXcode
//
//  Created by Janarthan Subburaj on 08/02/21.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var UsersProfileImage: UIImageView!
    @IBOutlet weak var UsersName: UILabel!
    @IBOutlet weak var UserLastMessage: UILabel!
    @IBOutlet weak var LastSeen: UILabel!
    @IBOutlet weak var Onlineoroffline: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Onlineoroffline.layer.cornerRadius = 10
        Onlineoroffline.layer.masksToBounds = true
        UsersProfileImage.layer.cornerRadius = 32
        UsersProfileImage.layer.masksToBounds = true
        UsersProfileImage.layer.borderWidth = 1
        UsersProfileImage.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
