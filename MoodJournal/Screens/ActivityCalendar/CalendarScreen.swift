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
    @State var showAddActivitySheet = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                CalendarHeader(calendarViewModel: $calendarViewModel, currentDate: $currentDate, changeToToday: $changeToToday, currentMonthIndex: $calendarViewModel.currentMonthIndex)
                
                ScrollView {
                    ForEach(calendarViewModel.getJournalEntryForDay(date: currentDate), id: \.id) { entry in
                        JournalEntryScreen(journalEntry: entry)
                    }
                    .padding()
                }
            }
            .vSpacing(.top)
            .navigationTitle("Calendar")
            .toolbar {
                ToolbarItem {
                    Button {
                        changeToToday = true
                    } label: {
                        Text("Today")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddActivitySheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddActivitySheet) {
                AddActivityScreen(calendarViewModel: $calendarViewModel, showSheet: $showAddActivitySheet)
            }
        }
    }
}

#Preview {
    CalendarScreen()
}
