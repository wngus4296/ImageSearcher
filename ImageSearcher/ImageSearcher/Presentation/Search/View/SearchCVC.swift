//
//  SearchCVC.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/05.
//

import UIKit

class SearchCVC: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier = "SearchCVC"
    
    // MARK: UI Component
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - UI
extension SearchCVC {
    
    private func setUI() {
        self.addSubview(imageView)
    }
    
    private func setConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
          imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
          imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
          imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
