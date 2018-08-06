//
//  APIClient.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 7/3/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func protocolDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

let apiUrlString: String = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let dateString = dateFormatter.string(from: Date())
    return "http://api.tvmaze.com/schedule?country=US&date=\(dateString)"
}()

class APIClient {
    
    static let shared = APIClient.init(session: URLSession(configuration: .default))
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
        
    }
    
    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.protocolDataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
    
    func queryEpisodes(callback: @escaping (_ episodes: [Episode], _ error: Error?) -> Void) {
        
        guard let url = URL(string: apiUrlString) else { return }
        
        let session = URLSession(configuration: .default)
        let apiClient = APIClient(session: session)
        var queryError: Error? = nil
        
        apiClient.get(url: url) { (data, error) in
            if let err = error {
                print("Error retrieving shows from TVMaze", err)
                queryError = err
                
            }
            
            guard let jsonData = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let totalEpisodes = try decoder.decode([Episode].self, from: jsonData)
                callback(totalEpisodes, queryError)
            } catch let err {
                print("Error decoding episodes from JSON", err)
            }
        }
        
    }
    
}

