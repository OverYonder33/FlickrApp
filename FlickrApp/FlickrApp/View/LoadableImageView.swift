//
//  LoadableImageView.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import UIKit

class LoadableImageView: UIImageView {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = .white
        activity.hidesWhenStopped = true
        self.addSubview(activity)
        activity.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        return activity
    }()

}
