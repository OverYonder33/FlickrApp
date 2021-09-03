//
//  URLSessionExtensions.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import Foundation

extension URLSession: Session {
    
    func fetch(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = self.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }

}
