//
//  ViewController.swift
//  ChatAppXcode
//
//  Created by Janarthan Subburaj on 08/02/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 89
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let UserCell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UsersTableViewCell
        UserCell.UsersName.text = ""
        UserCell.UserLastMessage.text = ""
        UserCell.LastSeen.text = ""
        UserCell.Onlineoroffline.text = ""
//        UserCell.UsersProfileImage.image = 
        return UserCell
    }
    
}

struct ChatUsers {
    let name:String?
    let lastmessage:String?
    let lastseen:String?
    let onlineorofflineStatus:String
    let userImage:UIImage
    init(name:String,lastmessage:String,lastseen:String,onlineorofflineStatus:String,userImage:UIImage) {
        self.name = name
        self.lastmessage = lastmessage
        self.lastseen = lastseen
        self.onlineorofflineStatus = onlineorofflineStatus
        self.userImage = userImage
    }
}
