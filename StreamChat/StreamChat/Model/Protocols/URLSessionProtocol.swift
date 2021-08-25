//
//  URLSessionProtocol.swift
//  StreamChat
//
//  Created by James on 2021/08/13.
//

import Foundation

protocol URLSessionProtocol {
    init(configuration: URLSessionConfiguration, delegate: URLSessionDelegate?, delegateQueue queue: OperationQueue?)
    func streamTask(withHostName hostname: String, port: Int) -> URLSessionStreamTask
    func invalidateAndCancel()
}
extension URLSession: URLSessionProtocol { }
