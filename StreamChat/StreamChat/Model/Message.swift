//
//  Message.swift
//  StreamChat
//
//  Created by James on 2021/08/13.
//

import Foundation

struct Message {
    let content: String
    let senderUsername: String
    let messageSender: MessageSender
    init(content: String, senderUsername: String, messageSender: MessageSender) {
        self.content = content
        self.senderUsername = senderUsername
        self.messageSender = messageSender
    }
}
