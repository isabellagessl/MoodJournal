//
//  AddActivityScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import SwiftUI

struct AddActivityScreen: View {
    @Binding var calendarViewModel: CalendarViewModel
    @Binding var showSheet: Bool
    @State var title = ""
    @State var date = Date()
    @State var description = ""
    
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "pencil.line")
                    .foregroundColor(.gray)
                    .frame(width: 20)
                TextField("", text: $title, prompt:
                            Text("title")
                    .foregroundColor(.gray.opacity(0.7))
                )
            }
            .frame(height: 60)
            .padding(.horizontal, 17)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.clear, lineWidth: 0)
            )
            
            Spacer().frame(height: 15)
            
            DatePicker(selection: $date, displayedComponents: .date) {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                        .frame(width: 20)
                    Text("date")
                        .foregroundColor(.gray.opacity(0.7))
                }
            }
            .frame(height: 60)
            .padding(.horizontal, 17)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            Spacer().frame(height: 15)
            
            HStack {
                TextField("", text: $description, prompt:
                            Text("description")
                    .foregroundColor(.gray.opacity(0.7))
                ).lineLimit(5, reservesSpace: true)
            }
            .frame(height: 60)
            .padding(.horizontal, 17)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.clear, lineWidth: 0)
            )
            
            Spacer().frame(height: 30)
            
            BigButton(title: "save", onClick: {calendarViewModel.journalEntries.append(JournalEntry(id: 0, title: title, description: description, date: date))
                showSheet = false
            })
        }
        .padding()
    }
}

#Preview {
    AddActivityScreen(calendarViewModel: .constant(CalendarViewModel()), showSheet: .constant(true))
}
