//
//  ImageCacheManager.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/07.
//

import UIKit

class ImageCacheManager {
   
   static let shared = NSCache<NSString, UIImage>()
   
   private init() {}
}
