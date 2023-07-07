//
//  ViewController.swift
//  ImageSearcher
//
//  Created by Juhyeon Byun on 2023/07/05.
//

import UIKit
import Combine

class SearchVC: UIViewController {
    
    // MARK: Properties
    static let identifier = "SearchVC"
    
    var imageList = [ImageEntity]()
    
    var imageVM: SearchVM = SearchVM()
    var disposalbleBag = Set<AnyCancellable>()
    
    // MARK: UI Component
    private let imageCV:  UICollectionView = {
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
extension SearchVC {
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(imageCV)
    }
    
    private func setConstraint() {
        imageCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          imageCV.leftAnchor.constraint(equalTo: self.view.leftAnchor),
          imageCV.rightAnchor.constraint(equalTo: self.view.rightAnchor),
          imageCV.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
          imageCV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
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
extension SearchVC {
    
    private func setBindings() {
        self.imageVM.$imageList.sink { (updatedList : [ImageEntity]) in
            self.imageList = updatedList
            self.imageCV.reloadData()
        }.store(in: &disposalbleBag)
    }
}

// MARK: - Custom Methods
extension SearchVC {
    
    private func setDelegate() {
        imageCV.register(SearchCVC.self, forCellWithReuseIdentifier: SearchCVC.identifier)
        imageCV.delegate = self
        imageCV.dataSource = self
    }
}

// MARK: - UISearchBarDelegate
extension SearchVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.imageVM.getImageList(input: text)
    }
}

// MARK: - UICollectionViewDataSource
extension SearchVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCVC.identifier, for: indexPath) as? SearchCVC else { return UICollectionViewCell() }
        cell.setImage(imageList[indexPath[1]].imageURL)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchVC: UICollectionViewDelegateFlowLayout {
    
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
