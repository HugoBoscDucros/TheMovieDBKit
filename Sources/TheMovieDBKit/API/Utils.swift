//
//  File.swift
//  
//
//  Created by Hugo Bosc-Ducros on 17/04/2023.
//

import Foundation

extension JSONDecoder {
    static var theMovieDB: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}

extension Decodable {
    static func decode(from:Data) throws -> Self {
        return try JSONDecoder.theMovieDB.decode(self, from: from)
    }
}
