//
//  ChatRoom.swift
//  StreamChat
//
//  Created by 김태형 on 2021/04/20.
//

import Foundation

class ChatRoom: NSObject {
    
    private var inputStream: InputStream?
    private var outputStream: OutputStream?
    private let maxLength = 300
    private var username = ""
    
    init(host: Host) {
        super.init()
        connect(host: host)
    }
    
    private func connect(host: Host) {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                           host.address,
                                           host.port,
                                           &readStream,
                                           &writeStream)
        
        inputStream = readStream?.takeRetainedValue()
        outputStream = writeStream?.takeRetainedValue()
        
        inputStream?.delegate = self
        
        inputStream?.schedule(in: .current, forMode: .default)
        outputStream?.schedule(in: .current, forMode: .default)
        
        inputStream?.open()
        outputStream?.open()
    }
    
    func joinChat(username: String) {
        guard let joinMessage = "USR_NAME::\(username)".data(using: .utf8) else {
            return
        }
        
        self.username = username
        
        joinMessage.withUnsafeBytes {
            guard let output = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("Error joining chat")
                return
            }
            outputStream?.write(output, maxLength: maxLength)
        }
    }
    
    func send(message: String) {
        let message = "MSG::\(message)".data(using: .utf8)!
        
        message.withUnsafeBytes {
            guard let output = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("Error send message")
                return
            }
            outputStream?.write(output, maxLength: maxLength)
        }
    }
    
    func disconnect() {
        inputStream?.close()
        outputStream?.close()
    }
}

extension ChatRoom: StreamDelegate {
    func stream(_ stream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .errorOccurred:
            print("ErrorOccurred")
        case .openCompleted:
            print("OpenCompleted")
        case .hasBytesAvailable:
            print("HasBytesAvailable")
            readAvailableBytes(stream: stream)
        case .endEncountered:
            print("EndEncountered")
            disconnect()
        case .hasSpaceAvailable:
            print("HasSpaceAvailable")
        default:
            print("unknown event")
        }
    }
    
    private func readAvailableBytes(stream: Stream) {
        guard let stream = stream as? InputStream else {
            return
        }
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxLength)
        
        while stream.hasBytesAvailable {
            guard let readByteNumber = inputStream?.read(buffer, maxLength: maxLength),
                  let input = String(bytesNoCopy: buffer,
                                     length: readByteNumber,
                                     encoding: .utf8,
                                     freeWhenDone: true) else {
                return
            }
            print(input)
        }
    }
}


