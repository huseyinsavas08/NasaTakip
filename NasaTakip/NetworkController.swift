//
//  NetworkController.swift
//  NasaTakip
//
//  Created by Hüseyin Savaş on 27.12.2022.
//

import Foundation
import UIKit

class NetworkController {
    
    func fetchPhotoInfo(date: String, completion: @escaping (PhotoInfo?) -> Void) {
        let baseUrl = URL(string: "https://api.nasa.gov/planetary/apod")!
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            "date": date
        ]
        let queryUrl = baseUrl.withQueries(query)!
        
        URLSession.shared.dataTask(with: queryUrl) { data, _, _ in
            let jsonDecoder = JSONDecoder()
            
            if let data = data, let photoInfoObject = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfoObject)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func fetchPhoto(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
