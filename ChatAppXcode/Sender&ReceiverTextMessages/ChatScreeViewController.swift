//
//  ChatScreeViewController.swift
//  ChatAppXcode
//
//  Created by Janarthan Subburaj on 08/02/21.
//

import UIKit

class ChatScreeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var SenderStruct = [[SenderTextStruct]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "SenderMessageTextTableViewCell",bundle: nil), forCellReuseIdentifier: "SenderCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SenderStruct.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let SenderCell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as! SenderMessageTextTableViewCell
        
        return SenderCell
    }

}

struct SenderTextStruct {
    let senderimage:UIImage?
    let textMessage:String?
    let time:String?
    let deliveredStatus:String?
    
    init(senderimage:UIImage?,textMessage:String?,time:String,deliveredStatus:String) {
        self.senderimage = senderimage
        self.textMessage = textMessage
        self.time = time
        self.deliveredStatus = deliveredStatus
    }
}
