//
//  JournalEntryScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import SwiftUI

struct JournalEntryScreen: View {
    var journalEntry: JournalEntry
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(journalEntry.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color("calendardate")
                        .secondary)
                
                Text(journalEntry.description)
                
            }
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .shadow(color: .primary, radius: 10)
                .frame(width: screenWidth - 30)
                .foregroundStyle(Color("journalbackground"))
        }
    }
}

#Preview {
    JournalEntryScreen(journalEntry: JournalEntry(id: 2, title: "Schwimmen", description: "Mit Mama am See banden", date: Date()))
}
