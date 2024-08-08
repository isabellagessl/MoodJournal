//
//  JournalEntry.swift
//  MoodJournal
//
//  Created by Isabella Geßl on 06.08.24.
//

import Foundation

struct JournalEntry: Codable, Identifiable, Hashable {
    var id: Int
    var title: String
    var description: String
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
