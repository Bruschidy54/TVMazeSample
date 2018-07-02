//
//  Show.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 6/26/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import Foundation

struct Episode: Codable {
    
    struct JsonImage: Codable {
        let medium: String?
    }
    
    struct Show: Codable {
        struct Network: Codable {
            let name: String?
        }
        
        struct Rating: Codable {
            let average: Double?
        }
        
        
        let image: JsonImage?
        let rating: Rating?
        let network: Network?
        let name: String?
        let genres: [String]
        let language: String?
        let summary: String?
        
    }
    
    let show: Show?
    let name: String?
    let url : String?
    let airstamp: String?
    let airtime: String?
    let airdate: String?
    let runtime: Double?
    let summary: String?
    let season: Int?
    let number: Int?
    let image: JsonImage?
    
    var airInterval: DateInterval?  {
        guard let airstamp = airstamp, let runtime = runtime else { return nil }
        
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: airstamp) {
                
        let airInterval = DateInterval(start: date, duration: runtime * 60.0)
        return airInterval
        } else { return nil }
        
    }
    
}

