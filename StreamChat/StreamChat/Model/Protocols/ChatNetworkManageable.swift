//
//  ChatNetworkManageable.swift
//  StreamChat
//
//  Created by James on 2021/08/17.
//

import Foundation

protocol ChatNetworkManageable: AnyObject {
    
    var urlSession: URLSessionProtocol { get set }
    var streamTask: URLSessionStreamTaskProtocol? { get set }
    
    func setUpNetwork()
    func read(completionHandler: @escaping (Result<Data, NetworkError>) -> Void)
    func write(data: Data)
    func closeStream()
}
