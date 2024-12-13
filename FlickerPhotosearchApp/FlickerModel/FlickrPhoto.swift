//
//  FlickrPhoto.swift
//  FlickerPhotosearchApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import Foundation

struct FlickrResponse: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrImage]
}

struct FlickrImage: Codable {
    let title: String
    let link: String
    let media: Media
    let date_taken: String
    let description: String
    let published: String
    let author: String
    let author_id: String
    let tags: String
}

struct Media: Codable {
    let m: String
}
