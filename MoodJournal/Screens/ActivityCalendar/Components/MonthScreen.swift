//
//  MonthScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import SwiftUI

struct MonthScreen: View {
    var month: [[Date.WeekDay]]
    @Binding var currentDate: Date
    @Binding var calendarViewModel: CalendarViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(month, id: \.first!.id) { week in
                WeekScreen(week: week, month: month, currentDate: $currentDate, calendarViewModel: $calendarViewModel)
//                    .padding(.horizontal, -15)
//                    .padding(.bottom, -80)
//                    .vSpacing(.top)
            }
        }
    }
}
