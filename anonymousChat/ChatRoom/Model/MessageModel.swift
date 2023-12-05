//
//  MessageModel.swift
//  anonymousChat
//
//  Created by Tanmay Chandra Nath on 03/12/23.
//

import Foundation

struct MessageModel {
    let senderName: String
    let message: String
    let time: String
}

extension Array where Element == MessageModel {
    func dataAsArrayOfDict() -> [String: Any] {
        var dictData: [String: Any] = ["-1":["sender": "", "message": ""]]
        for i in 0..<self.count {
            var newDict = ["sender": self[i].senderName, "message": self[i].message]
            dictData[String(i)] = newDict
        }
        return dictData
    }
}
