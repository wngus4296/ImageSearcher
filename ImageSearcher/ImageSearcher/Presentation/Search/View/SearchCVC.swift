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
    
    override func prepareForReuse() {
        imageView.image = UIImage()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - UI
extension SearchCVC {
    
    private func setUI() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
    }
    
    private func setConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
          imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
          imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
          imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}

// MARK: - Custom Methods
extension SearchCVC {
    
    func setImage(_ url: String) {
        imageView.setImageUrl(url)
    }
}
