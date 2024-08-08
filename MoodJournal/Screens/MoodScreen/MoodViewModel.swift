//
//  MoodViewModel.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 05.08.24.
//

import Foundation
import SwiftUI

@Observable
class MoodViewModel {
    var currentFeeling: Feeling
    var moods = [Mood(id: 0, name: "happy", categroyId: 0), Mood(id: 1, name: "loved", categroyId: 1), Mood(id: 2, name: "comfortable", categroyId: 0), Mood(id: 3, name: "tired", categroyId: 2), Mood(id: 4, name: "sad", categroyId: 2), Mood(id: 5, name: "sick", categroyId: 3)]
    
    var categories = [Category(id: 0, color: "lightgreen", name: "good", symbol: "sun.max"), Category(id: 1, color: "romaticred", name: "romantic", symbol: "heart.fill"), Category(id: 2, color: "tristblue", name: "trist", symbol: "cloud.rain.fill"), Category(id: 3, color: "unwellorange", name: "unwell", symbol: "cloud.fill")]
    
    var reasons = [Reason(id: 0, name: "partner", symbol: "heart.fill"), Reason(id: 1, name: "family", symbol: "figure.2.and.child.holdinghands"), Reason(id: 2, name: "friends", symbol: "figure.2.arms.open"), Reason(id: 3, name: "party", symbol: "balloon.2.fill"), Reason(id: 4, name: "vacation", symbol: "globe.europe.africa.fill"), Reason(id: 5, name: "work", symbol: "bag.fill")]
    
    init() {
        currentFeeling = Feeling(moodId: 0, reasonIds: [0], id: 0, date: Date())
    }
    
    func getCurrentMood() -> Mood? {
        return moods.first(where: {
            $0.id == currentFeeling.moodId
        })
    }
    
    func getCurrentCategory() -> Category? {
        return categories.first(where: {
            if let mood = getCurrentMood() {
                $0.id == mood.categroyId
            } else {
                true
            }
        })
    }
    
    func getCategoryColor() -> UIColor {
        if let category = getCurrentCategory() {
            return UIColor(Color(category.color)) 
            //?? UIColor.clear
        }
        return UIColor.clear
    }
    
    func getCategorySymbol() -> String {
        if let category = getCurrentCategory() {
            return category.symbol
        }
        return "sun.max"
    }
    
    func getMoodsForCategoryId(categoryId: Int) -> [Mood]{
        return moods.filter({
            $0.categroyId == categoryId
        })
    }
    
    func getCurrentReasons() -> [Reason] {
        return reasons.filter({currentFeeling.reasonIds.contains($0.id)})
    }
}
