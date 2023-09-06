//
//  Time.swift
//  TabBarTest
//
//  Created by ViceCode on 22.12.2021.
//

import Foundation

class TimeFormatter {
    
    // MARK: - Строку преобразуем во время
    
    static func utcToLocalTime(dateStr: String, complection: (String)->Void) {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: Double(dateStr)!)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        complection(dateFormatter.string(from: date))
    }
    
    // MARK: - Строку преобразуем во время
    
    static func utcToLocalDate(dateStr: String, complection: (String)->Void) {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: Double(dateStr)!)

        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "EEEE"
        complection(dateFormatter.string(from: date))
    }
    
    // Сегодняшняя дата в формате дата и месяц - "6 сентября"
    static func todayDay() -> String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        let today = Date()
        let midnight = calendar.startOfDay(for: today).timeIntervalSince1970
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd MMMM"
        let date = Date(timeIntervalSince1970: midnight)
        var tempDate = dateFormatter.string(from: date)
        
        // Удаляем 0 если число то 10
        if tempDate.first == "0" {
            tempDate.removeFirst()
        }
        return tempDate
    }
}
