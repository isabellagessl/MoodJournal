//
//  CalendarViewModel.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import Foundation

@Observable
class CalendarViewModel {
    var monthSlider: [[[Date.WeekDay]]] = []
    var currentMonthIndex = 1
    
    var journalEntries = [JournalEntry(id: "", title: "Steinberger See", description: "War mit meiner Mama am See baden", date: Date())]
    
    func paginateWeek() {
        if monthSlider.indices.contains(currentMonthIndex) {
            if let firstDate = monthSlider[currentMonthIndex].first?.first?.date, currentMonthIndex == 0 {
                print("firstDate \(firstDate)")
                monthSlider.insert(firstDate.createPreviousMonth(), at: 0)
                monthSlider.removeLast()
                currentMonthIndex = 1
            }
            
            if let lastDate = monthSlider[currentMonthIndex].last?.last?.date, currentMonthIndex == (monthSlider.count - 1) {
                print(lastDate)
                monthSlider.append(lastDate.createNextMonth())
                monthSlider.removeFirst()
                currentMonthIndex = monthSlider.count - 2
            }
        }
    }
    
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    func isDateInThisMonth(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, equalTo: date2, toGranularity: .month)
    }
    
    func getJournalEntryForDay(date: Date) -> [JournalEntry] {
        return journalEntries.filter({ isSameDate($0.date, date) })
    }
}
