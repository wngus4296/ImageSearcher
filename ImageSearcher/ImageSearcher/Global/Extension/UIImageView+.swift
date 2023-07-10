//
//  UIImageView+.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/07.
//

import UIKit

extension UIImageView {
    
    func setImageUrl(_ url: String) {
        let cacheKey = NSString(string: url)
        let cacheManager = NSCache<NSString, UIImage>()
         
         if let cachedImage = cacheManager.object(forKey: cacheKey) {
             self.image = cachedImage
             return
         }
         
         if let imageUrl = URL(string: url) {
             URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                 if let _ = err {
                     DispatchQueue.main.async {
                         self.image = nil
                     }
                     return
                 }
                 DispatchQueue.main.async {
                     if let data = data, let image = UIImage(data: data) {
                         cacheManager.setObject(image, forKey: cacheKey)
                         self.image = image
                     }
                 }
             }.resume()
         }
     }
 }
