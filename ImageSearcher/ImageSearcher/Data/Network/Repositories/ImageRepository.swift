//
//  ImageDataService.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/05.
//

import Foundation
import Combine

class ImageRepository {
    
    // 네트워크 레이어는 url, request, method, query
    func searchImages(query: String) -> AnyPublisher<SearchImageResponse, Error> {
        guard let url = URL(string: "https://dapi.kakao.com/v2/search/image?query=\(query)") else {
            return Fail(error: NSError(domain: "Invalid URL", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") {
            request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")}
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw NSError(domain: "HTTP Error", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)
                }
                return data
            }
            .decode(type: SearchImageResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
