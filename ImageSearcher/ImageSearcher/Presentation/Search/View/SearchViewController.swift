//
//  ViewController.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/05.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {
    
    // MARK: Properties
    var images = [ImageEntity]()
    
    var viewModel: SearchViewModel = SearchViewModel()
    var cancellables = Set<AnyCancellable>()
    
    
    // MARK: UI Component
    private let imageCollectionView:  UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.init(top: 3 , left: 3, bottom: 0, right: 3)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setSearchController()
        setUI()
        setConstraint()
        setDelegate()
        setBindings()
    }
}

// MARK: - UI
extension SearchViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(imageCollectionView)
    }
    
    private func setConstraint() {
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          imageCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
          imageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search images"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Image Search"
    }
}

// MARK: - View Model
extension SearchViewController {
    
    private func setBindings() {
        viewModel.$images.sink { (updatedList : [ImageEntity]) in
            self.images = updatedList
            self.imageCollectionView.reloadData()
        }.store(in: &cancellables)
    }
}

// MARK: - Custom Methods
extension SearchViewController {
    
    private func setDelegate() {
        imageCollectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.className)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.viewModel.getImages(input: text)
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.className, for: indexPath) as? SearchCell else { return UICollectionViewCell() }
        cell.setImage(images[indexPath[1]].imageUrlString)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interval:CGFloat = 3
        let width: CGFloat = (UIScreen.main.bounds.width - interval * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
