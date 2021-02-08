//
//  ReceiverMeassageTextTableViewCell.swift
//  ChatAppXcode
//
//  Created by Janarthan Subburaj on 08/02/21.
//

import UIKit

class ReceiverMeassageTextTableViewCell: UITableViewCell {

    @IBOutlet weak var ReceiverImage: UIImageView!
    
    @IBOutlet weak var UserTextView: UIView!
    
    @IBOutlet weak var UserTextMessage: UILabel!
    
    @IBOutlet weak var Time: UILabel!
    
    @IBOutlet weak var Statusmessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
