//
//  ServerImage.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 07.08.24.
//

import SwiftUI

@MainActor
struct ServerImage<ImageView: View>: View {
    var viewModel = PhotoViewModel()
    var imageId: String
    @ViewBuilder var content: (Image) -> ImageView
    
    @State var image: UIImage? = nil
    
    init(
        imageId: String,
        @ViewBuilder content: @escaping (Image) -> ImageView
    ) {
        self.imageId = imageId
        self.content = content
    }
    
    var body: some View {
        VStack {
            if let uiImage = image {
                content(Image(uiImage: uiImage))
            } else {
                ProgressView()
                .onAppear {
                    Task {
                        image = await viewModel.downloadPhoto(imageId: imageId)
                    }
                }
            }
        }
    }
    
    
}

