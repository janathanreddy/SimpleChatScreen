//
//  ChatScreeViewController.swift
//  ChatAppXcode
//
//  Created by Janarthan Subburaj on 08/02/21.
//

import UIKit
import Firebase

class ChatScreeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var TextShouldReturn: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var dateupdate:String?
    var timeupdate:String?
    var SenderStruct = [SenderTextStruct]()
    var DocumentId:String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        TextShouldReturn.delegate = self
        print("DocumentId : \(DocumentId)")
        tableView.register(UINib(nibName: "SenderMessageTextTableViewCell",bundle: nil), forCellReuseIdentifier: "SenderTextCell")
        tableView.register(UINib(nibName: "ReceiverMeassageTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiverTextCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        retrive()
    }
    func retrive(){
        db.collection("ChatApp").document("FtZrP14cYYaXo23KmtS0" ?? "").collection("messages").addSnapshotListener{ [self]QuerySnapShot,error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }else{
                for documents in QuerySnapShot!.documents{
                    let Document = documents.data()
                    SenderStruct.append(SenderTextStruct(senderimage: "image", textMessage: Document["text"] as!  String, time: "9.00 AM", deliveredStatus: Document["status"] as! String, Sender: true))
                    print("Document : \(Document)")
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if SenderStruct[indexPath.row].Sender == true{
            let SenderTextCell = tableView.dequeueReusableCell(withIdentifier: "SenderTextCell", for: indexPath) as! SenderMessageTextTableViewCell
            SenderTextCell.deiverstatus.text = "wait"
            SenderTextCell.senderTextMessage.text = "hi hello How are you ..."
            SenderTextCell.senderTextMessage.layer.cornerRadius = 20
            SenderTextCell.sendercahtimage.image = UIImage(systemName: "person")
            SenderTextCell.timetext.text = "7.00 AM"
            tableView.rowHeight = 130
            return SenderTextCell
//        }else if SenderStruct[indexPath.row].Sender == false{
//            let ReceiverTextCell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTextCell", for: indexPath) as! ReceiverMeassageTextTableViewCell
//            tableView.rowHeight = 130
//            ReceiverTextCell.ReceiverImage.image = UIImage(systemName: "person")
//            ReceiverTextCell.UserTextView.layer.cornerRadius = 20
//            ReceiverTextCell.UserTextView.layer.masksToBounds = true
//
//            ReceiverTextCell.UserTextMessage.text = "Hi"
//            ReceiverTextCell.Statusmessage.text = "wait"
//            ReceiverTextCell.Time.text = "3.33 PM"
//            return ReceiverTextCell
//        }
//        return UITableViewCell()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        date()
        time()
        let textFromField:String = TextShouldReturn.text!
        if TextShouldReturn.text?.isEmpty == true{
            let alert = UIAlertController(title: "", message: "Message TextField Empty", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )

        }
        else{
            db.collection("ChatApp").document(DocumentId ?? "").collection("messages").addDocument(data:["image":"Image","text":textFromField,"status":"check","time":timeupdate])
            tableView.reloadData()
            TextShouldReturn.text = ""
        }
        return true
    }


    
    func date(){
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateFormat = "dd MMMM yyyy"
        dateupdate = formatter.string(from: currentDateTime)
        
    }
    func time(){
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        timeupdate = formatter.string(from: currentDateTime)
 
    }


}

struct SenderTextStruct {
    let senderimage:String?
    let textMessage:String?
    let time:String?
    let deliveredStatus:String?
    let Sender:Bool?
    
    init(senderimage:String?,textMessage:String?,time:String,deliveredStatus:String,Sender:Bool) {
        self.senderimage = senderimage
        self.textMessage = textMessage
        self.time = time
        self.deliveredStatus = deliveredStatus
        self.Sender = Sender
    }
}
