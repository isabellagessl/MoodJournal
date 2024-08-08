//
//  ProfileScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import SwiftUI
import PhotosUI

struct ProfileScreen: View {
    @Binding var profileViewModel: ProfileViewModel
    @State private var selectedImage: PhotosPickerItem?
    
    var body: some View {
        VStack(alignment: .center) {
            if let user = profileViewModel.user {
                if user.profilePictureURL != "" {
                    ServerImage(imageId: user.profilePictureURL) { image in
                        image
                            .scaledToFill()
                            .frame(width: 170, height: 170)
                            .clipShape(Circle())
                            .padding([.leading, .trailing], 10)
                    }
                } else {
                    PhotosPicker(selection: $selectedImage, matching: .images) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 170, height: 170)
                            .foregroundColor(Color.secondary)
                            .padding([.leading, .trailing], 10)
                    }
                }
                Text(user.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color("calendardate"))
            }
            Spacer()
        }
        .onChange(of: selectedImage) {
            Task {
                let imageData = try? await selectedImage?.loadTransferable(type: Data.self)
                if var user = profileViewModel.user {
                    if let data = imageData, let uiImage = UIImage(data: data) {
                        if let profilePictureURL = await profileViewModel.uploadImage(imageData: uiImage.jpegData(compressionQuality: 0.6) ?? data) {
                            user.profilePictureURL = profilePictureURL
                        }
                        
                    }
                    print(user)
                    profileViewModel.updateUser(user: user)
                }
            }
        }
    }
}

