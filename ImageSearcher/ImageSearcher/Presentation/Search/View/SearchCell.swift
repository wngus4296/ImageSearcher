//
//  SearchCVC.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/05.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
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
        imageView.image = nil
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
}

// MARK: - UI
extension SearchCell {
    
    private func setUI() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
    }
    
    private func setConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
          imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
          imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
          imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

// MARK: - Custom Methods
extension SearchCell {
    
    func setImage(_ url: String) {
        imageView.setImageUrl(url)
    }
}
