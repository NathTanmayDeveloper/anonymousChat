//
//  ChatRoomViewController.swift
//  anonymousChat
//
//  Created by Tanmay Chandra Nath on 03/12/23.
//

import UIKit

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
        loadMessages()
        tableView.reloadData()
        messageTextField.becomeFirstResponder()
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
    
    private func loadMessages() {
        messages = [MessageModel(senderName: "Me", message: "Hiiakldklda adskdaklad adldalkadads laldas ad", time: "22:08"), MessageModel(senderName: "You", message: "Hii", time: "22:08"), MessageModel(senderName: "Me", message: "Hii", time: "22:08"), MessageModel(senderName: "You", message: "Hii", time: "22:08"), MessageModel(senderName: "Me", message: "Hii", time: "22:08"), MessageModel(senderName: "You", message: "Hii", time: "22:08")]
    }
    
    private var myName: String {
        return "Me"
    }
    
    @IBAction func snedButtonPressed(_ sender: UIButton) {
        guard let messageText = messageTextField.text else {return}
        let newMessage = MessageModel(senderName: myName, message: messageText, time: "22.08")
        messages.append(newMessage)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .bottom, animated: true)
    }
}

extension ChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages[indexPath.row].senderName == "Me" {
            return getMyMessageCell(tableView, cellForRowAt: indexPath)
        } else {
            return getOthersMessageCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    
    private func getMyMessageCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTableViewCell", for: indexPath) as? MyMessageTableViewCell
        if let cell = cell {
            cell.configure(message: messages[indexPath.row].message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private func getOthersMessageCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OthersMessageTableViewCell", for: indexPath) as? OthersMessageTableViewCell
        if let cell = cell {
            cell.configure(message: messages[indexPath.row].message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
