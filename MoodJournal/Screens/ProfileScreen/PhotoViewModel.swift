//
//  PhotoViewModel.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 07.08.24.
//

import Foundation
import UIKit

class PhotoViewModel {
    func downloadPhoto(imageId: String) async -> UIImage? {
        do {
            guard let url = URL(string: "\(ServerConfig.serverUrl)/image/\(imageId)") else { return nil }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(ServerConfig.authSecret, forHTTPHeaderField: "authorization")
            
            if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                return UIImage(data: cachedResponse.data)
            } else {
                let (data, response) = try await URLSession.shared.data(for: request)
                URLCache.shared.storeCachedResponse(.init(response: response, data: data), for: request)
                
                guard let image = UIImage(data: data) else {
                    return nil
                }
                
                return image
            }
        } catch {
            print("Error downloading: \(error)")
            return nil
        }
    }
}
