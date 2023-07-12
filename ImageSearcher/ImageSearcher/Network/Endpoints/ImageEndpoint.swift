//
//  ImageEnpoint.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/12.
//

import Foundation

enum ImageEndpoint {
    case getImages(input: String)
}

extension ImageEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getImages:
            return "v2/search/image"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getImages:
            return .get
        }
    }

    var parameters: RequestParams {
        switch self {
        case .getImages(let input):
            let requestQuery: [String: Any] = [
                "query": input
            ]
            return .requestQuery(requestQuery)
        }
    }

    var headers: HeaderType {
        switch self {
        case .getImages:
            return .auth
        }
    }
}
