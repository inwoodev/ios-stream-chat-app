//
//  Date+Extension.swift
//  StreamChat
//
//  Created by James on 2021/08/19.
//

import Foundation

extension Date {
    static let formatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var formattedString: String {
        Date.formatter.string(from: self)
    }
}
