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
    var Fire_store = Firestore.firestore()
    var DocumentId:String = "hi" 
    var ChatUser = [ChatUsers]()
    let settings = FirestoreSettings()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 89
        settings.isPersistenceEnabled = true
        Fire_store.settings = settings

        Fire_store.collection("ChatUsers").document("FtZrP14cYYaXo23KmtS5").addSnapshotListener{ [self]snapshotQuery,error in
            ChatUser.removeAll()
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }else{
                let snapshotQuery = snapshotQuery?.data()
                
                ChatUser.append(ChatUsers(name: snapshotQuery!["name"] as! String, lastmessage: snapshotQuery!["lastmeaasge"] as! String, lastseen: snapshotQuery!["lastseen"] as! String, onlineorofflineStatus: snapshotQuery!["onlinecheck"] as! String, userImage: snapshotQuery!["image"] as! String))
                print("ChatUser : \(ChatUser)")
                }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            }
    }

    override func viewWillAppear(_ animated: Bool) {
        Fire_store.collection("ChatUsers").addSnapshotListener(includeMetadataChanges: true) { [self] querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error retreiving snapshot: \(error!)")
                    return
                }

                for diff in snapshot.documentChanges {
                    if diff.type == .added {
                        print("New city: \(diff.document.data())")
                    }else if diff.type == .modified{
                        print("New city: \(diff.document.data())")
                    }else if diff.type == .removed{
                        print("New city: \(diff.document.data())")
                    }
                }
                    let source = snapshot.metadata.isFromCache ? "local cache" : "server"
                    print("Metadata: Data fetched from \(source)")
            if source == "local cache"{
                Fire_store.collection("ChatUsers").document("FtZrP14cYYaXo23KmtS5").updateData(["onlinecheck": "offline"])
            }else if source == "server"{
                Fire_store.collection("ChatUsers").document("FtZrP14cYYaXo23KmtS5").updateData(["onlinecheck": "online"])
            }
            
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let UserCell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UsersTableViewCell
        UserCell.UsersName.text = ChatUser[indexPath.row].name
        UserCell.UserLastMessage.text = ChatUser[indexPath.row].lastmessage
        UserCell.LastSeen.text = ChatUser[indexPath.row].lastseen
        if ChatUser[indexPath.row].onlineorofflineStatus == "online"{
            UserCell.Onlineoroffline.backgroundColor = UIColor.systemGreen
        }else{
            UserCell.Onlineoroffline.backgroundColor = UIColor.systemRed
        }
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
    let userImage:String
    init(name:String,lastmessage:String,lastseen:String,onlineorofflineStatus:String,userImage:String) {
        self.name = name
        self.lastmessage = lastmessage
        self.lastseen = lastseen
        self.onlineorofflineStatus = onlineorofflineStatus
        self.userImage = userImage
    }
}
