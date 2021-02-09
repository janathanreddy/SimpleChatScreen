//
//  ChatScreeViewController.swift
//  ChatAppXcode
//
//  Created by Janarthan Subburaj on 08/02/21.
//

import UIKit
import Firebase

class ChatScreeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var BottomConstraints: NSLayoutConstraint!
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
        retrive()
    }
    
    func retrive(){
        SenderStruct.removeAll()
        db.collection("ChatApp").document("FtZrP14cYYaXo23KmtS0" ?? "").collection("messages").order(by: "time").getDocuments{ [self]QuerySnapShot,error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }else{
                for documents in QuerySnapShot!.documents{
                    let Document = documents.data()
                    let time_Stamp = Document["time"] as? Timestamp
                    let timeStamp = time_Stamp?.dateValue()
                    let dateFormatter = DateFormatter()
                    dateFormatter.amSymbol = "AM"
                    dateFormatter.pmSymbol = "PM"
                    dateFormatter.dateFormat = "hh:mm a"
                    let ChatTime = dateFormatter.string(from: timeStamp!)
                    print("ChatTime : \(ChatTime)")
                    
                    SenderStruct.append(SenderTextStruct(senderimage: "image", textMessage: Document["text"] as!  String, time: ChatTime, deliveredStatus: Document["status"] as! String,Sender: true))
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SenderStruct.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if SenderStruct[indexPath.row].Sender == true{
            let SenderTextCell = tableView.dequeueReusableCell(withIdentifier: "SenderTextCell", for: indexPath) as! SenderMessageTextTableViewCell
            SenderTextCell.deiverstatus.text = SenderStruct[indexPath.row].deliveredStatus
            SenderTextCell.senderTextMessage.text = SenderStruct[indexPath.row].textMessage
            SenderTextCell.senderTextMessage.layer.cornerRadius = 20
//            SenderTextCell.sendercahtimage.image = UIImage(systemName: "person")
            SenderTextCell.timetext.text = SenderStruct[indexPath.row].time
            return SenderTextCell
        }else if SenderStruct[indexPath.row].Sender == false{
            let ReceiverTextCell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTextCell", for: indexPath) as! ReceiverMeassageTextTableViewCell
            ReceiverTextCell.ReceiverImage.image = UIImage(systemName: "person")
            ReceiverTextCell.UserTextView.layer.cornerRadius = 20
            ReceiverTextCell.UserTextView.layer.masksToBounds = true
            ReceiverTextCell.UserTextMessage.text = "Hi"
            ReceiverTextCell.Statusmessage.text = "wait"
            ReceiverTextCell.Time.text = "3.33 PM"
            return ReceiverTextCell
        }
        return UITableViewCell()
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
            db.collection("ChatApp").document("FtZrP14cYYaXo23KmtS0" ?? "").collection("messages").addDocument(data:["image":"Image","text":textFromField,"status":"check","time":FieldValue.serverTimestamp()])
            SenderStruct.append(SenderTextStruct(senderimage: "Image", textMessage: textFromField, time: timeupdate!, deliveredStatus: "wait", Sender: true))
            tableView.reloadData()
            scrollToBottom(animated: true)

            TextShouldReturn.text = ""
        }
        return true
    }

    fileprivate func scrollToBottom(animated: Bool) {
        if self.SenderStruct.count > 0 {
            let lastIndex = IndexPath(row: SenderStruct.count - 1, section: 0)
            self.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: animated)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollToBottom(animated: false)
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
