//
//  File.swift
//  
//
//  Created by Hugo Bosc-Ducros on 17/04/2023.
//

import Foundation

public struct Movie: Codable {
    
    private static var imagesURL = "https://image.tmdb.org/t/p/w500"
    
    public var id:Int
    public var title:String
    public var overview:String?
    public var voteAverage:Float
    public var voteCount:Int
    public var popularity:Float
    public var originalTitle:String
    public var originalLanguage:String
    public var releaseDate:Date
    public var posterPath:String?
    
    public var posterURL:URL? {
        guard let posterPath,
              let url = URL(string: Movie.imagesURL + posterPath)
        else {return nil}
        return url
    }
}

@available(iOS 13.0.0, *)
public extension Movie {
    static var Exemple:Movie {
        let url = Bundle.module.url(forResource: "MovieExemple", withExtension: "json")!
        let data = try! Data(contentsOf: url)
//        do {
            let movie =  try! Movie.decode(from: data)
            return movie
//        } catch {
//            print(error.localizedDescription)
//        }
//        return nil
    }
}
