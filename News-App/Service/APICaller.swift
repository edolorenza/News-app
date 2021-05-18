//
//  APICaller.swift
//  News-App
//
//  Created by Edo Lorenza on 18/05/21.
//
import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseUrl =  "https://newsapi.org/v2/"
        static let path = "top-headlines"
        static let apiKey = "e296a0c54e8b40ec8d279689e4a1b44b"
        static let endPoint = "id"
        static let searchUrlString = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=e296a0c54e8b40ec8d279689e4a1b44b&q="
        
    }
    
    enum APIError: Error {
        case invalidUrl
    }
    
    public func getTopNews(
        completion: @escaping (Result<[Articles], Error>) -> Void
    ){
        guard let url = URL(string: Constants.baseUrl + Constants.path + "?country=" + Constants.endPoint + "&apikey=" + Constants.apiKey) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(NewsData.self, from: data)
                completion(.success(response.articles))
                
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    public func searchNews(with query: String, completion: @escaping (Result<[Articles], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        guard let url = URL(string: Constants.searchUrlString + query) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(NewsData.self, from: data)
                completion(.success(response.articles))
                
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
