//
//  JournalEntryScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import SwiftUI

struct JournalEntryScreen: View {
    var journalEntry: JournalEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(journalEntry.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color("calendardate")
                    .secondary)
            
            Text(journalEntry.description)
                
        }
    }
}

#Preview {
    JournalEntryScreen(journalEntry: JournalEntry(id: "2", title: "Schwimmen", description: "Mit Mama am See banden", date: Date()))
}
