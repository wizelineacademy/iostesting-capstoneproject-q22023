//
//  HttpRequestHelper.swift
//  Capstone
//
//  Created by Carlos Ceja.
//

import Foundation

struct HttpRequestHelper {

    static func GET(url: String, completion: @escaping (Tweets?) -> ()) {

        guard let url = URL(string: url) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in

            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                completion(nil)
                return
            }

            guard let data = data else {
                print("Error: did not receive data")
                completion(nil)
                return
            }

            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                completion(nil)
                return
            }
            
            do {
                let timeline = try JSONDecoder().decode(Timeline.self, from: data)
                completion(timeline.tweets)
            }
            catch {
                completion(nil)
            }
        }.resume()
    }

}
