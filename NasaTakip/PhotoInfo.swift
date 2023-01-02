//
//  PhotoInfo.swift
//  NasaTakip
//
//  Created by Hüseyin Savaş on 27.12.2022.
//

import Foundation

struct PhotoInfo: Codable {
    
    let title: String?
    let description: String?
    let url: URL?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "explanation"
        case url = "url"
    }
}
