//
//  SearchVM.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/05.
//

import Foundation
import Combine


class SearchViewModel: ObservableObject {
    
    // MARK: Properties
    @Published var images = [ImageEntity]()
    
    private let imageRepository = ImageRepository()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Life Cycle
    init() { }
}

// MARK: - Custom Methods
extension SearchViewModel {

    func getImages(input: String) {
        imageRepository.searchImages(query: input)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] (result: SearchImageResponse) in
                self?.images = result.documents.map { return ImageEntity(imageUrlString: $0.imageURL) }
            })
            .store(in: &cancellables)
    }
}
