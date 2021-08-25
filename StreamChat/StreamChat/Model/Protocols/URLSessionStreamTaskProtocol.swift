//
//  URLSessionStreamTaskProtocol.swift
//  StreamChat
//
//  Created by James on 2021/08/19.
//

import Foundation

protocol URLSessionStreamTaskProtocol {
    func readData(ofMinLength minBytes: Int, maxLength maxBytes: Int, timeout: TimeInterval, completionHandler: @escaping (Data?, Bool, Error?) -> Void)
    func write(_ data: Data, timeout: TimeInterval, completionHandler: @escaping (Error?) -> Void)
    func resume()
    func closeWrite()
    func closeRead()
}
extension URLSessionStreamTask: URLSessionStreamTaskProtocol { }
