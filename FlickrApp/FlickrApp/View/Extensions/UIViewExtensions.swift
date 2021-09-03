//
//  UIViewExtensions.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import UIKit

extension UIView {
    
    func bindToSuper(insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)) {
        guard let safeArea = self.superview?.safeAreaLayoutGuide else {
            fatalError("Forgot to add the view to the view hierarchy")
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: insets.top).isActive = true
        self.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -insets.bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -insets.right).isActive = true
    }
    
    static func createBufferView() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }
    
}

