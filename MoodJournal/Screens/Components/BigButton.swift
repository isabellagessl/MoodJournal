//
//  BigButton.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 05.08.24.
//

import SwiftUI

struct BigButton: View {
    let title: String
    let disabled: Bool
    let backgroundColor: Color
    let onClick: () -> Void
    
    init(title: String, disabled: Bool = false, backgroundColor: Color = Color.blue, onClick: @escaping () -> Void) {
        self.title = title
        self.disabled = disabled
        self.backgroundColor = backgroundColor
        self.onClick = onClick
    }
    
    var body: some View {
        Button(action: onClick) {
            Text(title)
                .padding(12)
                .foregroundColor(Color.white)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .background(disabled ? backgroundColor.opacity(0.5) : backgroundColor)
                .cornerRadius(15)
                .listRowInsets(EdgeInsets())
        }
        .disabled(disabled)
    }
}
