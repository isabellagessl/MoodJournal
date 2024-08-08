//
//  MoodJournalApp.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 05.08.24.
//

import SwiftUI

@main
struct MoodJournalApp: App {
    @State var profileViewModel = ProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            if profileViewModel.user == nil {
                RegisterScreen(profileViewModel: $profileViewModel)
            } else {
                TabView {
                    MoodScreen()
                        .tabItem {
                            Label("Feelings", systemImage: "face.smiling")
                        }
                    
                    CalendarScreen()
                        .tabItem {
                            Label("Calendar", systemImage: "calendar")
                        }
                    ProfileScreen(profileViewModel: $profileViewModel)
                        .tabItem {
                            Label("Profile", systemImage: "person.circle.fill")
                        }
                }
            }
        }
    }
}
