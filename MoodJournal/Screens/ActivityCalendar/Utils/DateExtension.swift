//
//  DateExtension.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import SwiftUI

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    var idToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func getStartOfMonth(_ date: Date = .init()) -> Date {
        let calendar = Calendar.current
        guard let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else {
            return Date()
        }
        return firstOfMonth
    }
    
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        guard let startOfWeek = weekForDate?.start else {
            return []
        }
        
        (0..<7).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(.init(date: weekDay))
            }
        }
        
        return week
    }
    
    func createWeekdaysForMonth(_ date: Date = .init()) -> [[WeekDay]] {
        let calendar = Calendar.current
        guard let monthRange = calendar.range(of: .day, in: .month, for: date) else {
            return []
        }
        
        let firstOfMonth = calendar.dateComponents([.year, .month], from: date)
        
        let date = calendar.date(from: firstOfMonth)!

        var dates: [[WeekDay]] = []
        
//        dates.append(contentsOf: fetchWeek(date))
        
        for index in stride(from: monthRange.first ?? 0, through: monthRange.last ?? 30, by: 7) {
            if let nextDate = calendar.date(byAdding: .day, value: index, to: date) {
                dates.append(fetchWeek(nextDate))
            }
            
        }
        return dates
    }
    
    var startDateOfMonth: Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else {
            fatalError("Unable to get start date from date")
        }
        return date
    }

    var endDateOfMonth: Date {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startDateOfMonth) else {
            fatalError("Unable to get end date from date")
        }
        return date
    }
    
    func createNextMonth() -> [[WeekDay]] {
        let calendar = Calendar.current
//        let startOfLastDay = calendar.startOfDay(for: self)
//        
//        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDay) else {
//            return []
//        }
        let lastDate = self.endDateOfMonth
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: lastDate) else {
            return []
        }
            
        return createWeekdaysForMonth(nextDate)
    }
    
    func createPreviousMonth() -> [[WeekDay]] {
        let calendar = Calendar.current
        let startOfLFirstDay = self.startDateOfMonth
        
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfLFirstDay) else {
            return []
        }
        
        return createWeekdaysForMonth(previousDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
}
