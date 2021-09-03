//
//  FickrDetailViewController.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import UIKit

class FickrDetailViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        if let data = self.viewModel.imageData {
            imageView.image = UIImage(data: data)
        }
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Title: \(self.viewModel.title)"
        return label
    }()
    
    lazy var dimensionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Width: \(self.viewModel.width) Height: \(self.viewModel.height)"
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Author: \(self.viewModel.author)"
        return label
    }()
    
    
    let viewModel: ItemViewModelType
    
    init(viewModel: ItemViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.view.backgroundColor = .white
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 8
        
        let bufferTop = UIView.createBufferView()
        let bufferBottom = UIView.createBufferView()
        
        stack.addArrangedSubview(bufferTop)
        stack.addArrangedSubview(self.titleLabel)
        stack.addArrangedSubview(self.imageView)
        stack.addArrangedSubview(self.dimensionLabel)
        stack.addArrangedSubview(self.authorLabel)
        stack.addArrangedSubview(bufferBottom)
        
        self.view.addSubview(stack)
        stack.bindToSuper()
        
        bufferTop.heightAnchor.constraint(equalTo: bufferBottom.heightAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
