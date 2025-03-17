//
//  Flickr.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import Foundation

struct FlickrImages: Codable {
    let items: [FlickrImage]
}

struct FlickrImage: Codable, Identifiable, Hashable {
    let title: String?
    let link: String?
    let media: FlickrMedia?
    let date_taken: String?
    let description: String?
    let published: String?
    let author: String?
    let author_id: String?
    let tags: String?
    var tagList: [String]? {
        tags?.components(separatedBy: " ")
    }
    var id: String {
        link ?? ""
    }
    var parsedDescription: FlickImageDescription? {
        FlickrImageDescriptionParser.parse(description)
    }
    var formattedDate: String? {
        guard let dateTaken = date_taken else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateTaken) else {
            return dateTaken
        }
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct FlickrMedia: Codable, Hashable {
    let m: String?
    var url: URL? {
        URL(string: m ?? "")
    }
}

struct FlickImageDescription {
    let authorName: String?
    let authorLink: String?
    let imagePageLink: String?
    let imageTitle: String?
    let imageURL: String?
    let imageWidth: Int?
    let imageHeight: Int?
    let text: String?
}
