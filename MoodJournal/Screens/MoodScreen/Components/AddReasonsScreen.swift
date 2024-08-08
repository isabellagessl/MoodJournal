//
//  AddReasonsScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 05.08.24.
//

import SwiftUI
import WrappingHStack

struct AddReasonsScreen: View {
    @Binding var moodViewModel: MoodViewModel
    @Binding var showSheet: Bool
    @Binding var selectedCategory: Category
    @Binding var selectedMood: Mood
    
    @State var reasons: [Reason]
    
    var body: some View {
        VStack {
            Text("What influences how you feel?")
                .font(.system(size: 30))
                .bold()
            WrappingHStack {
                ForEach(moodViewModel.reasons, id: \.id) { reason in
                    ReasonTag(reason: reason, active: reasons.contains(where: {$0.id == reason.id}), category: selectedCategory, onClick: {
                        if !reasons.contains(where: {$0.id == reason.id}) {
                            reasons.append(reason)
                        } else {
                            reasons.remove(at: reasons.firstIndex(where: {$0.id == reason.id}) ?? 0)
                        }
                    })
                }
            }
            
            Spacer().frame(height: 15)
            BigButton(title: "save", onClick: {
                moodViewModel.currentFeeling = Feeling(moodId: selectedMood.id, reasonIds: reasons.map({$0.id}), id: 1, date: Date())
                showSheet.toggle()
            })
            .padding()
        }
    }
}

