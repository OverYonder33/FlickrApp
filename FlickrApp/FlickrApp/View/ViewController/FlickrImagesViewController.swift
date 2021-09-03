//
//  FickrImagesViewController.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import UIKit

class FlickrImagesViewController: UIViewController {

    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar(frame: .zero)
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = "Search"
        bar.delegate = self
        bar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return bar
    }()
    
    lazy var collection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        
        return collection
    }()
    
    let viewModel: ListViewModelType = FlickrFeedListViewModel(service: NetworkCaller())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        
        self.viewModel.bind { [weak self] in
            DispatchQueue.main.async {
                self?.collection.reloadData()
            }
        } errorH: { err in
            // Add Visual Error handling here if relevant for user
            print(err)
        }

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = self.collection.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    private func setUp() {
        self.title = "Flickr Images"
        self.view.backgroundColor = .white
        
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 8
        
        stack.addArrangedSubview(self.searchBar)
        stack.addArrangedSubview(self.collection)
        self.view.addSubview(stack)
        stack.bindToSuper()
    }
    

}

extension FlickrImagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(viewModel: self.viewModel, index: indexPath.row)
        return cell
    }

}

extension FlickrImagesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel.itemViewModel(for: indexPath.item) else { return }
        let detailVC = FickrDetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension FlickrImagesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.width, height: 200)
    }
    
}

extension FlickrImagesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.getItems(query: searchText)
    }
    
}
