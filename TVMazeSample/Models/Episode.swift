//
//  Show.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 6/26/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import Foundation

struct Episode: Codable {
    
    let show: Show?
    let name: String?
    let url : String?
    let airstamp: String?
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

