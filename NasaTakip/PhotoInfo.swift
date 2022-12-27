//
//  PhotoInfo.swift
//  NasaTakip
//
//  Created by Hüseyin Savaş on 27.12.2022.
//

import Foundation

struct PhotoInfo: Codable {
    
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
    }
}
