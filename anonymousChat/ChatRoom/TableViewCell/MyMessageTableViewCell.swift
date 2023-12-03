//
//  MyMessageTableViewCell.swift
//  anonymousChat
//
//  Created by Tanmay Chandra Nath on 03/12/23.
//

import UIKit

class MyMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = 8.0
        // Initialization code
    }
    
    func configure(message: String) {
        messageLabel.text = message
    }
}
