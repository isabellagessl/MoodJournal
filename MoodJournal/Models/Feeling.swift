//
//  Mood.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 05.08.24.
//

import Foundation

struct Feeling: Codable, Identifiable, Hashable {
    var moodId: String
    var reasonIds: [String]
    var id: String
    var date: Date
    
    static func decodeJSON(from data: Data) throws -> [Feeling] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([Feeling].self, from: data)
    }

    static func encodeJSON(_ feeling: Feeling) throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(feeling)
    }
}

struct Category: Codable, Identifiable, Hashable {
    var id: String
    var color: String
    var name: String
    var symbol: String
    
    static func decodeJSON(from data: Data) throws -> [Category] {
        let decoder = JSONDecoder()
        return try decoder.decode([Category].self, from: data)
    }

    static func encodeJSON(_ category: Category) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(category)
    }
}

struct Mood: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var categroyId: String
    
    static func decodeJSON(from data: Data) throws -> [Mood] {
        let decoder = JSONDecoder()
        return try decoder.decode([Mood].self, from: data)
    }

    static func encodeJSON(_ mood: Mood) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(mood)
    }
}

struct Reason: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var symbol: String
    
    static func decodeJSON(from data: Data) throws -> [Reason] {
        let decoder = JSONDecoder()
        return try decoder.decode([Reason].self, from: data)
    }

    static func encodeJSON(_ reason: Reason) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(reason)
    }
}
