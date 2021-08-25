//
//  ChatNetworkManager.swift
//  StreamChat
//
//  Created by James on 2021/08/17.
//

import Foundation

final class ChatNetworkManager: NSObject, ChatNetworkManageable {
    
    var urlSession: URLSessionProtocol
    var streamTask: URLSessionStreamTaskProtocol?
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func setUpNetwork() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        self.streamTask = urlSession.streamTask(withHostName: StreamInformation.host, port: StreamInformation.portNumber)
        streamTask?.resume()
    }
    
    func read(completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        streamTask?.readData(ofMinLength: ConnectionConfiguration.minimumReadLength, maxLength: ConnectionConfiguration.maximumReadLength, timeout: ConnectionConfiguration.timeOut) { data, _, error in

            guard let data = data else {
                return
            }
            
            completionHandler(.success(data))
            
            // MARK: - Read Log
            NSLog(String(data: data, encoding: .utf8) ?? "no message could be read")
            
            if let readError = error {
                NSLog(readError.localizedDescription)
            }
        }
    }
    
    func write(data: Data) {
        streamTask?.write(data, timeout: ConnectionConfiguration.timeOut) { error in
            if let writeError = error {
                NSLog(writeError.localizedDescription)
            }
        }
    }
    
    func closeStream() {
        urlSession.invalidateAndCancel()
    }
}
extension ChatNetworkManager: URLSessionStreamDelegate {
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        streamTask?.closeRead()
        streamTask?.closeWrite()
    }
}
