//
//  Video.swift
//  VideoFeed
//
//  Created by Илья Меркуленко on 11.07.2023.
//

import Foundation

struct Video: Identifiable, Codable {
    var id: String {
        return UUID().uuidString
    }
    let videoUrl: String
}
