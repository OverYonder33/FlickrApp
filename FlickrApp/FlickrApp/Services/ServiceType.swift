//
//  ServiceType.swift
//  FlickrApp
//
//  Created by Carlos Henderson on 9/3/21.
//

import Foundation

protocol ServiceType {
    func requestModel<T: Decodable>(url: URL?, completion: @escaping (Result<T, Error>) -> Void)
    func requestRawData(url: URL?, completion: @escaping (Result<Data, Error>) -> Void)
}
