//
//  ChatRoomViewController.swift
//  anonymousChat
//
//  Created by Tanmay Chandra Nath on 03/12/23.
//

import UIKit
import FirebaseDatabase

class ChatRoomViewController: UIViewController {
    
    private var messages: [MessageModel] = []
    var roomId: String = ""
    
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        tableView.dataSource = self
        setNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        sendButton.layer.cornerRadius = 24.0
        messageTextField.layer.cornerRadius = 24.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        messageTextField.becomeFirstResponder()
        observeDataBaseValue()
    }
    
    private func setNavigationBar() {
        navigationItem.title = roomId
        navigationItem.backButtonTitle = ""
        navigationItem.titleView?.backgroundColor = .brown
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "MyMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MyMessageTableViewCell")
        tableView.register(UINib(nibName: "OthersMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "OthersMessageTableViewCell")
    }
    
    private var myName: String {
        return UserRepository.shared.userName ?? ""
    }
    
    @IBAction func snedButtonPressed(_ sender: UIButton) {
        guard let messageText = messageTextField.text else {return}
        let newMessage = MessageModel(senderName: myName, message: messageText, time: "22.08")
        var messagesCopy = messages
        messagesCopy.append(newMessage)
        DatabaseHelper.shared.updatedMessagesInto(roomId: roomId, updatedMessages: messagesCopy)
        checkForMessageAndScrollToBottomIfNeeded()
    }
    
    func checkForMessageAndScrollToBottomIfNeeded() {
        tableView.reloadData()
        if (messages.count > 0) {
            tableView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .bottom, animated: true)
        }
    }
    
    func observeDataBaseValue() {
        let ref = Database.database().reference()
        let refHandle = ref.observe(DataEventType.value, with: { snapshot in
            guard let dictValue = snapshot.value as? NSDictionary else {return}
            guard let userDetails = dictValue["users"] as? NSDictionary else {return}
            guard let messagesDetails = userDetails[self.roomId] as? NSDictionary else {return}
            var i = 0
            self.messages = []
            while messagesDetails[String(i)] as? NSDictionary != nil {
                if let currentAddedMessage = messagesDetails[String(i)] as? NSDictionary {
                    self.messages.append(MessageModel(senderName: currentAddedMessage["sender"] as! String, message: currentAddedMessage["message"] as! String, time: "0"))
                    i = i + 1
                } else {
                    break
                }
            }
            self.checkForMessageAndScrollToBottomIfNeeded()
        })
    }
}

extension ChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages[indexPath.row].senderName == self.myName {
            return getMyMessageCell(tableView, cellForRowAt: indexPath)
        } else {
            return getOthersMessageCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    
    private func getMyMessageCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTableViewCell", for: indexPath) as? MyMessageTableViewCell
        if let cell = cell {
            cell.configure(message: messages[indexPath.row].message, senderName: messages[indexPath.row].senderName)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private func getOthersMessageCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OthersMessageTableViewCell", for: indexPath) as? OthersMessageTableViewCell
        if let cell = cell {
            cell.configure(message: messages[indexPath.row].message, senderName: messages[indexPath.row].senderName)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
