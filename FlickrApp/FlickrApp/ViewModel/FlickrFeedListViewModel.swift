//
//  FlickrFeedListViewModel.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import Foundation

typealias UpdateHandler = () -> Void
typealias ErrorHandler = (Error) -> Void


protocol ListViewModelType {
    var count: Int { get }
    func image(for index: Int, completion: @escaping (Data?) -> Void)
    func itemViewModel(for index: Int) -> ItemViewModelType?
    func getItems(query: String)
    func bind(updateH: @escaping UpdateHandler, errorH: @escaping ErrorHandler)
}

class FlickrFeedListViewModel {
    
    let service: ServiceType
    
    var updateHandler: UpdateHandler?
    var errorHandler: ErrorHandler?
    
    var imageFeedArr: [ImageFeed] = []
    
    init(service: ServiceType) {
        self.service = service
    }
    
}

extension FlickrFeedListViewModel: ListViewModelType {
    
    func bind(updateH: @escaping UpdateHandler, errorH: @escaping ErrorHandler) {
        self.updateHandler = updateH
        self.errorHandler = errorH
    }
    
    
    func getItems(query: String) {
        guard !query.isEmpty else {
            self.imageFeedArr = []
            self.updateHandler?()
            return
        }
        
        self.service.requestModel(url: NetworkRequests.feed(query).url) { [weak self] (result: Result<FlickrFeed, Error>) in
            switch result {
            case .success(let feed):
                self?.imageFeedArr = feed.items
                self?.updateHandler?()
            case .failure(let error):
                self?.errorHandler?(error)
            }
        }
    }
    
    var count: Int {
        return imageFeedArr.count
    }
    
    func image(for index: Int, completion: @escaping (Data?) -> Void) {
        guard index < self.count else {
            completion(nil)
            return
        }
        
        if let imageData = ImageCache.sharedCache.get(url: self.imageFeedArr[index].media.imageLink) {
            completion(imageData)
            return
        }
        let key = self.imageFeedArr[index].media.imageLink
        
        self.service.requestRawData(url: NetworkRequests.image(self.imageFeedArr[index].media.imageLink).url) { result in
            switch result {
            case .success(let imageData):
                ImageCache.sharedCache.set(data: imageData, url: key)
                completion(imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func itemViewModel(for index: Int) -> ItemViewModelType? {
        guard index < self.count else { return nil }
        return FlickrFeedItemViewModel(item: self.imageFeedArr[index])
    }
    
}
