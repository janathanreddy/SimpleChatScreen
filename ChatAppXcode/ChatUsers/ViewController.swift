//
//  ViewController.swift
//  ChatAppXcode
//
//  Created by Janarthan Subburaj on 08/02/21.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var DocumentId:String = "hi" 
    
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath : \(indexPath)")
        performSegue(withIdentifier: "ChatScreen", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatScreen"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let Controller = segue.destination as! ChatScreeViewController
                Controller.DocumentId = DocumentId
            }
        }
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
