//
//  Session.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import Foundation

protocol Session {
    func fetch(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
