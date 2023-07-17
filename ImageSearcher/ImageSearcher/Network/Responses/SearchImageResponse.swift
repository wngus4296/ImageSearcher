//
//  SearchImageResponse.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/05.
//

import Foundation

struct SearchImageResponse: Codable {
    let documents: [Document]
    let meta: Meta
}

struct Document: Codable {
    let collection: String?
    let datetime: String?
    let displaySitename: String?
    let docURL: String?
    let height: Int?
    let imageURL: String?
    let thumbnailURL: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case collection, datetime
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.collection = try container.decodeIfPresent(String.self, forKey: .collection)
        self.datetime = try container.decodeIfPresent(String.self, forKey: .datetime)
        self.displaySitename = try container.decodeIfPresent(String.self, forKey: .displaySitename)
        self.docURL = try container.decodeIfPresent(String.self, forKey: .docURL)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.thumbnailURL = try container.decodeIfPresent(String.self, forKey: .thumbnailURL)
        self.width = try container.decodeIfPresent(Int.self, forKey: .width)
    }
}

struct Meta: Codable {
    let isEnd: Bool?
    let pageableCount: Int?
    let totalCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isEnd = try container.decodeIfPresent(Bool.self, forKey: .isEnd)
        self.pageableCount = try container.decodeIfPresent(Int.self, forKey: .pageableCount)
        self.totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
    }
}
