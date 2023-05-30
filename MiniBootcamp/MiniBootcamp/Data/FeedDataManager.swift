//
//  FeedDataManager.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 25/05/23.
//

import Foundation

protocol FeedDataManagerProtocol {
    func fetch(completion: @escaping (Result<[Tweet], Error>) -> Void)
}

class FeedDataManager: FeedDataManagerProtocol {
    
    var endpointURL =  "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json"
    
    func fetch(completion: @escaping (Result<[Tweet], Error>) -> Void) {
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let url = URL(string: endpointURL)
        
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data \(String(describing: data))")
            print("Response \(String(describing: response))")
            print("Error \(String(describing: error))")
            
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0)))
                return
            }
            
            do {
                print("Success - - - :) ")
                let timeline = try JSONDecoder().decode(Tweets.self, from: data)
                print(timeline)
                completion(.success(timeline.tweets))
                
            } catch {
                print("PARSE ERRORRR")
                completion(.failure(NSError(domain: "", code: 0)))
                
            }
            
            
        }.resume()
        
    }
    
    
    
}
