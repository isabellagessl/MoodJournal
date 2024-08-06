//
//  CalendarHeader.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import SwiftUI

struct CalendarHeader: View {
    @Binding var calendarViewModel: CalendarViewModel
    @Binding var currentDate: Date
    @Binding var changeToToday: Bool
    @Binding var currentMonthIndex: Int
    @State private var createMonths = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(currentDate.format("MMM"))
                    .foregroundStyle(Color("calendardate"))
                Text(currentDate.format("YYY"))
                    .foregroundStyle(.secondary)
            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.secondary)
            
            TabView(selection: $currentMonthIndex) {
                ForEach(calendarViewModel.monthSlider.indices, id: \.self) {index in
                    let month = calendarViewModel.monthSlider[index]
                    MonthScreen(month: month, currentDate: $currentDate, calendarViewModel: $calendarViewModel)
                        .tag(index)
                }
            }.tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 320)
//                .padding(.horizontal, 12)
            Spacer()
        }
        .padding(15)
        .hSpacing(.leading)
        .background(.white)
        .onAppear {
            if calendarViewModel.monthSlider.isEmpty {
                let currentWeeks = Date().createWeekdaysForMonth()
                
                if let firstDate = currentWeeks.first?.first?.date {
                    calendarViewModel.monthSlider.append(firstDate.createPreviousMonth())
                }
                
                calendarViewModel.monthSlider.append(currentWeeks)
                
                if let lastDate = currentWeeks.last?.last?.date {
                    calendarViewModel.monthSlider.append(lastDate.createNextMonth())
                }
            }
        }
        .onChange(of: currentMonthIndex, initial: false) { oldValue, newValue in
            calendarViewModel.currentMonthIndex = currentMonthIndex
            calendarViewModel.paginateWeek()
        }
        .onChange(of: changeToToday) {
            if changeToToday {
                calendarViewModel.monthSlider = []
                let currentWeeks = Date().createWeekdaysForMonth()
                
                if let firstDate = currentWeeks.first?.first?.date {
                    calendarViewModel.monthSlider.append(firstDate.createPreviousMonth())
                }
                
                calendarViewModel.monthSlider.append(currentWeeks)
                
                if let lastDate = currentWeeks.last?.last?.date {
                    calendarViewModel.monthSlider.append(lastDate.createNextMonth())
                }
                currentDate = Date()
                changeToToday.toggle()
            }
        }
    }
}

#Preview {
    CalendarHeader(calendarViewModel: .constant(CalendarViewModel()), currentDate: .constant(Date()), changeToToday: .constant(false), currentMonthIndex: .constant(0))
}
