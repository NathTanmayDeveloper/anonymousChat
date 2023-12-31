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
        guard let roomId = joinTextField.text, !roomId.isEmpty else {
            joinTextField.addShakingAnimation(duration: 0.5, displacement: 15)
            return
        }
        
        guard let userName = nameTextField.text, !userName.isEmpty else {
            nameTextField.addShakingAnimation(duration: 0.5, displacement: 15)
            return
        }
        
        UserRepository.shared.userName = userName
        DatabaseHelper.shared.checkForIfRoomNumberExists(roomId: roomId) { isRoomExists in
            if isRoomExists {
                self.openChatRoom(withRoomId: roomId)
            }
        }
    }
    
    
    @IBAction func createNewButtonPressed(_ sender: UIButton) {
        guard let userName = nameTextField.text, !userName.isEmpty else {
            nameTextField.addShakingAnimation(duration: 0.5, displacement: 15)
            return }
        UserRepository.shared.userName = userName
        let roomId = generateRandomRoomId()
        DatabaseHelper.shared.createRoom(roomId: roomId)
        openChatRoom(withRoomId: roomId)
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
