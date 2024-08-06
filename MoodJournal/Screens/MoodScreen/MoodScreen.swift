//
//  MoodScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 05.08.24.
//

import SwiftUI

struct MoodScreen: View {
    @State var moodViewModel = MoodViewModel()
    @State var showAddMoodSheet: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: moodViewModel.getCategorySymbol())
//                    .resizable()
//                    .frame(width: 80, height: 80)
                    .font(.system(size: 80))
                    .foregroundStyle(Color(uiColor: UIColor.systemBackground))
                    .padding()
                    .background {
                        Circle().frame(width: 120)
                            .foregroundStyle (
                                Color(uiColor: moodViewModel.getCategoryColor())
                            )
                    }
                Text(moodViewModel.getCurrentMood()?.name ?? "")
                    .font(.system(size: 23))
                    .bold()
                Spacer()
            }
            .navigationTitle("Mood")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddMoodSheet.toggle()
                    } label: {
                        Text("add mood")
                    }
                }
            }
            .sheet(isPresented: $showAddMoodSheet) {
                AddMoodScreen(moodViewModel: $moodViewModel, showSheet: $showAddMoodSheet)
            }
        }
    }
}

#Preview {
    MoodScreen()
}
