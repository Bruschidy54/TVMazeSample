//
//  Show.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 6/26/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import Foundation

struct Episode: Codable {
    
    struct Show: Codable {
        struct Network: Codable {
            let name: String
        }
        
        struct Rating: Codable {
            let average: Double
        }
        
        struct ShowImage: Codable {
            let medium: String
        }
        
        let image: ShowImage
        let rating: Rating
        let network: Network
        let name: String
        let genres: [String]
        let language: String
        let summary: String
        
    }
    
    let show: Show
    let name: String
    let url : String
    let airtime: String
    let airdate: String
    let runtime: Int
    let summary: String
    let season: Int
    let number: Int
    let image: String
    
}

