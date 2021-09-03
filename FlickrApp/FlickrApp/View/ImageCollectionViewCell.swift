//
//  ImageCollectionViewCell.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "\(ImageCollectionViewCell.self)"
    
    lazy var imageView: LoadableImageView = {
        let imageView = LoadableImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var imageURL: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.contentView.addSubview(imageView)
        imageView.bindToSuper()
    }
    
    func configure(viewModel: ListViewModelType, index: Int) {
        self.imageView.image = nil
        self.imageView.activityIndicator.startAnimating()
        
        viewModel.image(for: index) { [weak self] data in
            DispatchQueue.main.async {
                if let data = data {
                    self?.imageView.image = UIImage(data: data)
                }
                self?.imageView.activityIndicator.stopAnimating()
            }
        }
    
    }
    
}
