//
//  NetworkError.swift
//  StreamChat
//
//  Created by James on 2021/08/18.
//

import Foundation

enum NetworkError: Error {
    case unableToReadDataFromNetwork
    case unableToWriteDataToNetwork
    case connectionError
    case unknownError
}
