//
//  CalendarScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import SwiftUI

struct CalendarScreen: View {
    @State private var calendarViewModel = CalendarViewModel()
    @State private var currentDate: Date = Date()
    @State var changeToToday = false
//    @State private var weekSlider: [[[Date.WeekDay]]] = []
//    @State private var currentWeekIndex: Int = 1
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                CalendarHeader(calendarViewModel: $calendarViewModel, currentDate: $currentDate, changeToToday: $changeToToday, currentMonthIndex: $calendarViewModel.currentMonthIndex)
                
                ScrollView {
                    ForEach(calendarViewModel.getJournalEntryForDay(date: currentDate), id: \.id) { entry in
                        let _ = print(entry)
                        JournalEntryScreen(journalEntry: entry)
                    }
                    .padding()
                }
            }
            .vSpacing(.top)
            .navigationTitle("Calendar")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        changeToToday = true
                    } label: {
                        Text("Today")
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarScreen()
}
