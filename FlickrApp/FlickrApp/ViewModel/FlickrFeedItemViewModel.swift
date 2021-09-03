//
//  FlickrFeedItemViewModel.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import Foundation

protocol ItemViewModelType {
    var imageData: Data? { get }
    var title: String { get }
    var width: String { get }
    var height: String { get }
    var author: String { get }
}

class FlickrFeedItemViewModel {
    
    let imageFeed: ImageFeed
    
    init(item: ImageFeed) {
        self.imageFeed = item
    }
    
}

extension FlickrFeedItemViewModel: ItemViewModelType {
    
    var imageData: Data? {
        return ImageCache.sharedCache.get(url: imageFeed.media.imageLink)
    }
    
    var title: String {
        return self.imageFeed.title
    }
    
    // Need to update these
    var width: String {
        return self.imageFeed.description.components(separatedBy: " ").filter { str in
            return str.contains("width")
        }.first?.filter({ char in
            return (0...9).contains(Int(String(char)) ?? -1)
        }) ?? "0"
    }
    
    var height: String {
        return self.imageFeed.description.components(separatedBy: " ").filter { str in
            return str.contains("height")
        }.first?.filter({ char in
            return (0...9).contains(Int(String(char)) ?? -1)
        }) ?? "0"
    }
    
    var author: String {
        return self.imageFeed.author.components(separatedBy: " ").last?.components(separatedBy: CharacterSet.alphanumerics.inverted).joined() ?? "Unknown"
    }
    
}
