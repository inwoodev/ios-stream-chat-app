//
//  ChatReadable.swift
//  StreamChat
//
//  Created by James on 2021/08/18.
//

import Foundation

protocol ChatReadable: AnyObject {
    func fetchMessageFromServer(data: Data)
}
