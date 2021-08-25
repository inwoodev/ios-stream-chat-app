//
//  MockChatNetworkManager.swift
//  StreamChatTests
//
//  Created by James on 2021/08/19.
//
@testable import StreamChat
import Foundation

final class MockChatNetworkManager: ChatNetworkManageable {
    var urlSession: URLSessionProtocol
    var streamTask: URLSessionStreamTaskProtocol?
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func setUpNetwork() {
        self.streamTask = MockStreamTask()
    }
    
    func read(completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        streamTask?.readData(ofMinLength: ConnectionConfiguration.minimumReadLength, maxLength: ConnectionConfiguration.maximumReadLength, timeout: ConnectionConfiguration.timeOut, completionHandler: { data, bool, error in
            completionHandler(.success(data!))
        })
    }
    
    func write(data: Data) {
        streamTask?.write(data, timeout: ConnectionConfiguration.timeOut, completionHandler: { error in
        })
    }
    
    func closeStream() {
        streamTask?.closeRead()
        streamTask?.closeWrite()
    }
    
    
}
