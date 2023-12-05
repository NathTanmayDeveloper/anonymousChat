//
//  ViewController.swift
//  anonymousChat
//
//  Created by Tanmay Chandra Nath on 03/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var joinTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func joinButtonPressed(_ sender: UIButton) {
        guard let roomId = joinTextField.text else { return }
        openChatRoom(withRoomId: roomId)
    }
    
    
    @IBAction func createNewButtonPressed(_ sender: UIButton) {
        openChatRoom(withRoomId: generateRandomRoomId())
    }
    
    
    func generateRandomRoomId() -> String {
        let randomInt = Int.random(in: 0...1000)
        return String(randomInt)
    }
    
    func openChatRoom(withRoomId roomId: String) {
        navigationController?.navigationBar.backgroundColor = .brown
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let chatVc = ChatRoomViewController(nibName: "ChatRoomViewController", bundle: nil)
        chatVc.roomId = roomId
        navigationController?.pushViewController(chatVc, animated: true)
    }
}

