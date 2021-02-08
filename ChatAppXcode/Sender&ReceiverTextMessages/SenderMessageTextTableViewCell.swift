//
//  SenderMessageTextTableViewCell.swift
//  ChatAppXcode
//
//  Created by Janarthan Subburaj on 08/02/21.
//

import UIKit

class SenderMessageTextTableViewCell: UITableViewCell {

    @IBOutlet weak var senderTextMessage: UILabel!
    @IBOutlet weak var deiverstatus: UILabel!
    @IBOutlet weak var timetext: UILabel!
    @IBOutlet weak var sendercahtimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
