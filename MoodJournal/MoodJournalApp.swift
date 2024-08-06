//
//  MoodJournalApp.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 05.08.24.
//

import SwiftUI

@main
struct MoodJournalApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MoodScreen()
                    .tabItem {
                        Label("Feelings", systemImage: "face.smiling")
                    }
                
                CalendarScreen()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                ProfileScreen()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle.fill")
                    }
            }
        }
    }
}
