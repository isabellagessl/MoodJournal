//
//  RegisterScreen.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 07.08.24.
//

import SwiftUI
import PhotosUI

struct RegisterScreen: View {
    @Binding var profileViewModel: ProfileViewModel
    @State var user = User(id: 0, deviceId: "", name: "", profilePictureURL: "", friends: [])
    let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    @State private var selectedImage: PhotosPickerItem?
    @State var imageData: Data?
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedImage, matching: .images) {
                if let imageData = imageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.secondary)
                }
            }
            
            Spacer().frame(height: 15)
            HStack {
                Section(header: Text("Name").font(.system(size: 20)).fontWeight(.semibold).padding(.leading, 10.0)) {
                    HStack {
                        Spacer(minLength: 18)
                        Image(systemName: "person.crop.circle")
                        TextField("enter username", text: $user.name).padding()
                            .cornerRadius(20.0)
                    }.background(Color("lightblue")).cornerRadius(20.0)
                }
            }
            Spacer().frame(height: 30)
            
            BigButton(title: "save", disabled: user.name.isEmpty) {
                Task {
                    if let data = imageData, let uiImage = UIImage(data: data) {
                        user.profilePictureURL = await profileViewModel.uploadImage(imageData: uiImage.jpegData(compressionQuality: 0.6) ?? data) ?? ""
                    } else {
                        user.profilePictureURL = ""
                    }
                    user.deviceId = deviceId
                    profileViewModel.createUser(user: user) 
                }
            }
        }.padding()
        .onChange(of: selectedImage) {
            Task {
                imageData = try? await selectedImage?.loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    RegisterScreen(profileViewModel: .constant(ProfileViewModel()))
}
