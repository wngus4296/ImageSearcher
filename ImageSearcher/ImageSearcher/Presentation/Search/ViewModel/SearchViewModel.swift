//
//  SearchVM.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/05.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    // MARK: Properties
    let imageSubject = CurrentValueSubject<[ImageEntity], Never>([])
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Life Cycle
    init() { }
}

// MARK: - Custom Methods
extension SearchViewModel {

    func getImages(input: String) {
        networkService.request(ImageEndpoint.getImages(input: input))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] (result: SearchImageResponse) in
                self?.imageSubject.send(result.documents.map { return ImageEntity(imageUrlString: $0.imageURL) })
            })
            .store(in: &cancellables)
    }
}
