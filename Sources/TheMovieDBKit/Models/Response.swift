//
//  File.swift
//  
//
//  Created by Hugo Bosc-Ducros on 17/04/2023.
//

import Foundation

public struct Response<T:Codable>: Codable {
    public var page:Int
    public var totalPages:Int
    public var totalResults:Int
    public var results:[T]
}
