//
//  Time.swift
//  TabBarTest
//
//  Created by ViceCode on 22.12.2021.
//

import Foundation

class TimeFormatter {
    static func utcToLocal(dateStr: String, complection: (String)->Void) {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: Double(dateStr)!)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        complection(dateFormatter.string(from: date))
        
    }
}
