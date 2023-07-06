//
//  SearchVM.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/05.
//

import Foundation
import Combine


class SearchVM: ObservableObject {
    
    // MARK: Properties
    @Published var imageList = [ImageEntity]()
    
    private let imageRepository = ImageRepository()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Life Cycle
    init() { }
}

// MARK: - Custom Methods
extension SearchVM {

    func getImageList(input: String) {
        imageRepository.searchImages(query: input)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] (result: SearchImageResModel) in
                self?.imageList = result.documents.map { return ImageEntity(imageURL: $0.imageURL) }
            })
            .store(in: &cancellables)
        
    }
}
