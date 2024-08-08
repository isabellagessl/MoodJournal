//
//  SocketService.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 07.08.24.
//

import Foundation
import SocketIO
import UIKit

class SocketService {
    static let instance = SocketService()
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    init() {
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        manager = SocketManager(
            socketURL: URL(string: ServerConfig.serverUrl)!,
            config: [
                .log(false),
                .compress,
                //.extraHeaders(["authorization": uuid])
                .extraHeaders(["authorization": ServerConfig.authSecret, "deviceId": uuid])
            ]
        )
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.connect()
    }
}
