//
//  CategoryItem.swift
//  Strichliste
//
//  Created by Isabella Geßl on 05.08.24.
//

import SwiftUI

struct CategoryItem: View {
    var category: Category
    let onClick: () -> Void
    let active: Bool
    
    var body: some View {
        Image(systemName: category.symbol)
//            .resizable()
            .font(.system(size: 15))
            .padding()
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

