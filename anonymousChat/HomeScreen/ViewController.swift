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
    }
    
    
    @IBAction func createNewButtonPressed(_ sender: UIButton) {
        navigationController?.navigationBar.backgroundColor = .brown
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let chatVc = ChatRoomViewController(nibName: "ChatRoomViewController", bundle: nil)
        chatVc.roomId = "123"
        navigationController?.pushViewController(chatVc, animated: true)
    }
    
}

