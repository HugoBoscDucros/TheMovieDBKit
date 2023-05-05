//
//  File.swift
//  
//
//  Created by Hugo Bosc-Ducros on 17/04/2023.
//

import Foundation

class APIBuilder {
    
    var apiKey:String
    private var host = "api.themoviedb.org"
    
    init(apiKey:String) {
        self.apiKey = apiKey
    }
    
    
    func getUrl(for path:String, query:String? = nil, year:Int? = nil, page: Int?) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/3/\(path)"
        components.queryItems = queries(query:query, year: year, page:page)
        return components.url
    }
    
    private func queries(query:String?, year:Int?, page:Int?) -> [URLQueryItem] {
        var queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        if let query {
            queryItems.append(URLQueryItem(name: "query", value: "\(query)"))
        }
        if let year {
            queryItems.append(URLQueryItem(name: "year", value: "\(year)"))
        }
        if let page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        return queryItems
    }
    
}


@available(iOS 13.0.0, *)
@available(macOS 10.15.0, *)
public class API {
    
    var apiBuilder:APIBuilder
    
    init(apiKey: String) {
        self.apiBuilder = APIBuilder(apiKey: apiKey)
    }
    
    private func getMovieDataFromURL(_ url:URL) async throws -> Response<Movie> {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let movies = try Response<Movie>.decode(from: data)
            return movies
        } catch {
            print("Invalid data")
            throw(error)
        }
    }
    
    private func fetchMovies(from url:URL, completion:@escaping([Movie])->()) {
        Task {
            do {
                let response = try await getMovieDataFromURL(url)
                completion(response.results)
            } catch {
                completion([])
            }
        }
    }

    public func getPopularMovies(page:Int? = nil, completion:@escaping([Movie])->()) {
        guard let url = apiBuilder.getUrl(for: "movie/popular", page: page) else {
            print("fail getting URL")
            return
        }
        fetchMovies(from: url, completion: completion)
    }
    
    public func search(_ query:String, year:Int? = nil, page:Int? = nil,completion:@escaping([Movie])->()) {
        guard let url = apiBuilder.getUrl(for: "search/movie", query: query, page: page) else {
            print("fail getting URL")
            return
        }
        fetchMovies(from: url, completion: completion)
    }
}

enum APICallError:Error {
    case urlConstruction
}
