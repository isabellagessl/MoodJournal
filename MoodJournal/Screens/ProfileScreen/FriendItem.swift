//
//  FriendItem.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 07.08.24.
//

import SwiftUI

struct FriendItem: View {
    var friend: User
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        HStack() {
            if friend.profilePictureURL != "" {
                ServerImage(imageId: friend.profilePictureURL) { image in
                    image
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .padding([.leading, .trailing], 10)
                }
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.secondary)
                    .padding([.leading, .trailing], 10)
            }
            
            Text(friend.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color("calendardate").secondary)
        }
        .hSpacing(.leading)
        .padding()
        .background (
            RoundedRectangle(cornerRadius: 20)
                .shadow(color: .primary, radius: 10)
                .frame(width: screenWidth - 30)
                .foregroundStyle(Color("journalbackground"))
        )
    }
}

#Preview {
    FriendItem(friend: User(id: 0, deviceId: "", name: "Test", profilePictureURL: "", friends: []))
}
