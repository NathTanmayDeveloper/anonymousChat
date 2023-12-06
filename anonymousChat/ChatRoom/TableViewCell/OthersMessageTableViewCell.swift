//
//  OthersMessageTableViewCell.swift
//  anonymousChat
//
//  Created by Tanmay Chandra Nath on 03/12/23.
//

import UIKit

class OthersMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = 8.0
        // Initialization code
    }
    
    func configure(message: String, senderName: String) {
        senderLabel.text = senderName
        messageLabel.text = message
    }
}
