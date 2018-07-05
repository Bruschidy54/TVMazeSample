//
//  Show.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 7/4/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import Foundation

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
    let url: String
    let genres: [String]
    let language: String?
    let summary: String?
    
    // Add shows variable in future release
    // let shows: [Show]
    
}
