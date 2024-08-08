//
//  AddMoodScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 05.08.24.
//

import SwiftUI
import WrappingHStack

struct AddMoodScreen: View {
    @Binding var moodViewModel: MoodViewModel
    @Binding var showSheet: Bool
    @State var selectedCategory: Category
    @State var selectedMood: Mood?
    
    init(moodViewModel: Binding<MoodViewModel>, showSheet: Binding<Bool>) {
        _selectedCategory = State(initialValue: moodViewModel.categories.first?.wrappedValue ?? Category(id: 0, color: "", name: "", symbol: ""))
        self._moodViewModel = moodViewModel
        self._showSheet = showSheet
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("How are you feeling?")
                    .font(.system(size: 30))
                    .bold()
                HStack {
                    ForEach(moodViewModel.categories, id: \.id) { category in
                        CategoryItem(category: category, onClick: {selectedCategory = category}, active: selectedCategory.id == category.id)
                    }
                }
                Spacer().frame(height: 15)
                WrappingHStack {
                    ForEach(moodViewModel.getMoodsForCategoryId(categoryId: selectedCategory.id), id: \.id) { mood in
                        MoodTag(mood: mood, active: selectedMood?.id ?? 0 == mood.id, category: selectedCategory, onClick: {selectedMood = mood})
                    }
                }
                Spacer().frame(height: 15)
                NavigationLink {
                    if let mood = selectedMood {
                        AddReasonsScreen(moodViewModel: $moodViewModel, showSheet: $showSheet, selectedCategory: $selectedCategory, selectedMood: .constant(mood), reasons: [])
                    }
                } label: {
                    Text("proceed")
                        .padding(12)
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .background(selectedMood == nil ? Color.blue.opacity(0.5) : Color.blue)
                        .cornerRadius(15)
                        .listRowInsets(EdgeInsets())
                }.disabled(selectedMood == nil)
                    .padding()
                
            }
        }
    }
}
