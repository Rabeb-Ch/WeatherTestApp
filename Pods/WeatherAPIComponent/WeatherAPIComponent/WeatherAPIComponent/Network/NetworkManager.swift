//
//  NetworkManager.swift
//  WeatherAPIComponent
//
//  Created by Rabeb Chelbi on 7/8/2022.
//
import Foundation

/// Used for Fetching Events for a query or Fetching Favorited Events
struct NetworkManager {
    /**
     * Generic func to fetch data with given params.
     
     * - parameter url: The URL to be retrieved
     * - parameter type:  the type of the value to decode from the json object.
     */
    func fetchAPI<T:Decodable>(fromUrl url : URL,forType type: T.Type,
                               completion : @escaping ((Result<T, NetworkError>) -> Void)) {
        //Create a task and give it to a session
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Check network error
            if error != nil {
                completion(.failure(.networkRequestFailed))
                return
            }
            
            // Unwrap Data
            guard let data = data else {
                completion(.failure(.jsonSerializationFailed))
                return
            }
            do {
                //create a jsonDecoder
                let decoder = JSONDecoder()
                //add a decoding strategy
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // Decode JSON from data and return a value of the type you specify 
                let objectToDecode = try decoder.decode(T.self, from: data)
                completion(.success(objectToDecode))
            } catch {
                completion(.failure(.jsonDecodingFailed))
            }
        }
        task.resume()
    }
}
