//
//  Extensions.swift
//  airlines
//
//  Created by 张铮琦 on 1/31/19.
//  Copyright © 2019 张铮琦. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var originalUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        originalUrlString = urlString
        
        let url = URL(string: "https://www.kayak.com" + urlString)
        image = nil
    
    if let imageFromCache = imageCache.object(forKey:  urlString as NSString) {
         self.image = imageFromCache
    }
    
    URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
        if error != nil {
            return
        }
        DispatchQueue.main.async {
            let imageToCache = UIImage(data: data!)
            
            if(self.originalUrlString == urlString) {
                self.image = imageToCache
            }
            
            imageCache.setObject(imageToCache!, forKey: urlString as NSString)
        }
    }).resume()
  }
}

