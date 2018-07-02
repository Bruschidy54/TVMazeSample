//
//  CustomImageView.swift
//  TVMazeSample
//
//  Created by Dylan Bruschi on 6/27/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewHeight = self.frame.size.height
            
            let ratio = myViewHeight/myImageHeight
            let scaledWidth = myImageWidth * ratio
            
            return CGSize(width: scaledWidth, height: myViewHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }
    
    func loadImage(urlString: String) {
        
        lastURLUsedToLoadImage = urlString
        
        self.image = nil
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image:", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                
                self.image = photoImage
            }
            }.resume()
    }
}
