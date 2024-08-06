//
//  WeekView.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import SwiftUI

struct WeekScreen: View {
    var week: [Date.WeekDay]
    var month: [[Date.WeekDay]]
    @Binding var currentDate: Date
    @Binding var calendarViewModel: CalendarViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(week) {day in
                let index = month.firstIndex(where: {$0.contains(where: {$0.id == day.id})})
                VStack(spacing: 8) {
                    if index ?? 0 == 0 {
                        Text(day.date.format("E"))
                            .font(.callout)
                            .fontWeight(.medium)
                            .textScale(.secondary)
                            .foregroundStyle(.black)
                    }
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(calendarViewModel.isSameDate(day.date, currentDate) ? Color(uiColor: UIColor.systemBackground) : calendarViewModel.isSameDate(day.date, Date()) ? .red : calendarViewModel.isDateInThisMonth(day.date, currentDate) ? .primary : .secondary)
                        .frame(width: 35, height: 35)
                        .background {
                            if calendarViewModel.isSameDate(day.date, currentDate) {
                                Circle()
                                    .fill(calendarViewModel.isSameDate(day.date, Date()) ? .red : .primary)
                                //                                    .frame(width: 5)
                            }
                        }
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
                
            }
        }
    }
}


