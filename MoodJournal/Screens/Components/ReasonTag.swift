//
//  ReasonTag.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 05.08.24.
//

import SwiftUI

struct ReasonTag: View {
    var reason: Reason
    let active: Bool
    var category: Category
    var onClick: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: reason.symbol)
            Text(reason.name)
                .font(.system(size: 12)).lineLimit(1)
        }
            .padding(.vertical, 4)
            .padding(.horizontal, 7)
            .foregroundColor(active ? Color(UIColor.systemBackground) : Color(category.color))
            .background(active ? Color(category.color) : Color.clear)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(category.color), lineWidth: 1.5)
                
            )
            .onTapGesture {
                onClick()
            }
    }
}

