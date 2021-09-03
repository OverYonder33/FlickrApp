//
//  MockService.swift
//  FlickrAppTests
//
//  Created by Carlos Henderson on 9/3/21.
//

import UIKit
@testable import FlickrApp

class MockService: ServiceType {
    
    func requestModel<T>(url: URL?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        
        guard let url = url else {
            completion(.failure(NetworkError.badRequest))
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            MockSession().fetch(url: url) { data, response, error in
                guard let data = data else {
                    completion(.failure(NetworkError.badData))
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    print(error)
                }
            }
        }
        
        
    }
    
    func requestRawData(url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            guard let data = UIImage(named: "Sample")?.jpegData(compressionQuality: 1.0) else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            completion(.success(data))
        }
    }
    
//    private func createFeed<T: Decodable>() -> T? {
//        var items: [ImageFeed] = []
//        for _ in 0..<3 {
//            items.append(ImageFeed(title: "Risso's dolphin - Dauphin de Risso (Grampus griseus)", link: "https://www.flickr.com/photos/vincentpommeyrol/51399561581/", media: Media(imageLink: "https://live.staticflickr.com/65535/51399561581_51f5bfed01_m.jpg"), description: " <p><a href=\"https://www.flickr.com/people/vincentpommeyrol/\">Vincent Pommeyrol</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/vincentpommeyrol/51399561581/\" title=\"Risso&#039;s dolphin - Dauphin de Risso (Grampus griseus)\"><img src=\"https://live.staticflickr.com/65535/51399561581_51f5bfed01_m.jpg\" width=\"240\" height=\"160\" alt=\"Risso&#039;s dolphin - Dauphin de Risso (Grampus griseus)\" /></a></p> <p>Risso's dolphin - Dauphin de Risso (Grampus griseus) of mediterranean sea.🐠 🌊 🌏 👉 <a href=\"http://www.vincentpommeyrol.com\" rel=\"noreferrer nofollow\">www.vincentpommeyrol.com</a><br /> <a href=\"http://www.youtube.com/user/Superbulleur/featured\" rel=\"noreferrer nofollow\">www.youtube.com/user/Superbulleur</a></p>", published: "2021-08-24T14:19:02Z", author: "nobody@flickr.com (\"Vincent Pommeyrol\")", tags: "cetacea dauphinbleuetblanc discoverwildlife epinephelusmarginatus grampusgriseus mammifère mammifèremarin natgeo rissosdolphindauphinderisso rorqualcommun stenellacoeruleoalba stripeddolphin wildlifeplanet wildlifeig adventure animal animals biodiversity birds cetace colors croisiere croixdusud cruise cétacé dauphin diving dolphin earth earthfocus earthofficial earthpicsnatureshotplanetearth environment exploration fauna fish flora mammal mammals marinelife mediterraneansea mediterranee natureaddict naturegeography naturelover naturephotography ocean oceanconservation oceanprotection oceanlife planete planeteocean protection reef reeffish reserve scubadiving sea sealife travel underwater underwaterphotographer underwaterlife underwaterphotography underwtatercolors vincentpommeyrol whale wild wildlife wildlifephotography"))
//        }
//        
//        return FlickrFeed(title: "Recent Uploads tagged dolphin and whale", link: "https://www.flickr.com/photos/", description: "", modified: "2021-08-24T14:19:02Z", generator: "https://www.flickr.com", items: items) as? T
//    }
    
}
