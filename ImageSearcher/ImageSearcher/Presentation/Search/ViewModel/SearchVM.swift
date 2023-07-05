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
    @Published var imageList = [String]()
    
    // MARK: Life Cycle
    init() { }
}

// MARK: - Custom Methods
extension SearchVM {
    
    // TODO: - 네트워크 통신
    @objc func getImageList(input: String) {
        print("view model 호출, input 값은 \(input)")
        imageList.append("\(input)")
    }
}
