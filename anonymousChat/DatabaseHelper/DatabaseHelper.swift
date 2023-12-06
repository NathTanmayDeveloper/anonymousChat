//
//  DatabaseHelper.swift
//  anonymousChat
//
//  Created by Tanmay Chandra Nath on 05/12/23.
//

import Foundation
import FirebaseDatabase

class DatabaseHelper {
    static let shared = DatabaseHelper()
    var ref: DatabaseReference!
    
    private init() {
        ref = Database.database().reference()
    }
    
    func createRoom(roomId: String) {
        self.ref.child("users").child(roomId).setValue(["-1": ["sender": "", "message": ""]])
    }
    
    func updatedMessagesInto(roomId: String, updatedMessages: [MessageModel]) {
        let data = updatedMessages.dataAsArrayOfDict() as NSDictionary
        print("data to add: \(data)")
        self.ref.child("users").child(roomId).setValue(data)
    }
    
    func checkForIfRoomNumberExists(roomId: String, completion: @escaping ((Bool) -> Void)) {
        self.ref.child("users").child(roomId).getData { error, snapshot in
            guard let dictValue = snapshot?.value as? NSDictionary else {
                completion(false)
                return
            }
            guard let firstMessage = dictValue["-1"] as? NSDictionary else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
