//
//  MockURLSession.swift
//  StreamChatTests
//
//  Created by James on 2021/08/13.
//
@testable import StreamChat
import Foundation

final class MockURLSession: URLSessionProtocol {
    
    var configuration: URLSessionConfiguration
    var delegate: URLSessionDelegate?
    var delegateQueue: OperationQueue?
    var didStreamConnectionFail = false
    var mockStreamTask: URLSessionStreamTaskProtocol?
    
    init(configuration: URLSessionConfiguration, delegate: URLSessionDelegate?, delegateQueue: OperationQueue?) {
        self.configuration = configuration
        self.delegate = delegate
        self.delegateQueue = delegateQueue
    }
    
    func invalidateAndCancel() {
        mockStreamTask?.closeRead()
        mockStreamTask?.closeWrite()
    }
    
    func streamTask(withHostName hostname: String, port: Int) -> URLSessionStreamTask {
        mockStreamTask = MockStreamTask()
        return mockStreamTask! as! URLSessionStreamTask
    }
    
    
}
