//
//  ProfileViewModel.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 07.08.24.
//

import Foundation
import UIKit
import Alamofire

@Observable
class ProfileViewModel {
    var user: User?
    let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    let socket = SocketService.instance.socket
    
    let ROUTE_PREFIX = "/users"
    
    init() {
        socket.on("\(ROUTE_PREFIX)/state") { data, ack in
            guard let decodedData = try? User.decodeSingleJSON(from: (data[0] as! String).data(using: .utf8)!) else {
                print("nene")
                return
            }
            self.user = decodedData
        }
        
        socket.emit("\(ROUTE_PREFIX)/state")
    }
    
    func createUser(user: User) {
        guard let data = try? User.encodeJSON(user) else {
            return
        }
        socket.emit("\(ROUTE_PREFIX)/createUser", data)
    }
    
    func deleteUser(id: Int) {
        socket.emit("\(ROUTE_PREFIX)/deleteUser", id)
    }
    
    func updateUser(user: User) {
        guard let data = try? User.encodeJSON(user) else {
            return
        }
        socket.emit("\(ROUTE_PREFIX)/updateUser", data)
    }
    
    func uploadImage(imageData: Data) async -> String? {
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "authorization": ServerConfig.authSecret
        ]
        
        return await withCheckedContinuation { continuation in
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                },
                to: "\(ServerConfig.serverUrl)/image",
                headers: headers
            )
            .responseString { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
}
