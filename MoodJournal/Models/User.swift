//
//  User.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 07.08.24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    var id: Int
    var deviceId: String
    var name: String
    var profilePictureURL: String
    var friends: [Friend]
    
    static func decodeSingleJSON(from data: Data) throws -> User {
        let decoder = JSONDecoder()
        return try decoder.decode(User.self, from: data)
    }
    
    static func encodeJSON(_ user: User) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(user)
    }
}

struct Friend: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var profilePitureURL: String
    
    static func decodeJSON(from data: Data) throws -> [Friend] {
        let decoder = JSONDecoder()
        return try decoder.decode([Friend].self, from: data)
    }
    
    static func encodeJSON(_ friend: Friend) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(friend)
    }
}
