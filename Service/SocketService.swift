//
//  SocketService.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import Foundation
import SocketIO

class SocketService {
    static let instance = SocketService()
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    init() {
        manager = SocketManager(
            socketURL: URL(string: ServerConfig.serverUrl)!,
            config: [
                .log(false),
                .compress,
                .extraHeaders(["authorization": ServerConfig.authSecret])
            ]
        )
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.connect()
    }
}
