//
//  FlickrImageDescriptionParser.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import UIKit

actor FlickrImageDescriptionParser {
    
    static func parse(_ description: String?) -> FlickImageDescription? {
        guard let description else { return nil }
        
        let authorLinkRegex = /<a href="([^"]+)">([^<]+)<\/a>/
        let imageLinkRegex = /<a href="([^"]+)" title="([^"]+)">/
        let imageSizeRegex = /<img src="([^"]+)" width="(\d+)" height="(\d+)"/
        let descriptionRegex = /<p>([^<]+)<\/p>/
        
        var authorName: String? = nil
        var authorLink: String? = nil
        var imagePageLink: String? = nil
        var imageTitle: String? = nil
        var imageURL: String? = nil
        var imageWidth: Int? = nil
        var imageHeight: Int? = nil
        var text: String? = nil
        
        if let match = description.firstMatch(of: authorLinkRegex) {
            authorName = "\(match.2)"
            authorLink = "\(match.1)"
        }

        if let match = description.firstMatch(of: imageLinkRegex) {
            imagePageLink = "\(match.1)"
            imageTitle = "\(match.2)"
        }

        if let match = description.firstMatch(of: imageSizeRegex) {
            imageURL = "\(match.1)"
            imageWidth = Int("\(match.2)")
            imageHeight = Int("\(match.3)")
        }

        if let match = description.firstMatch(of: descriptionRegex) {
            text = "\(match.1)"
        }

        return FlickImageDescription(
            authorName: authorName,
            authorLink: authorLink,
            imagePageLink: imagePageLink,
            imageTitle: imageTitle,
            imageURL: imageURL,
            imageWidth: imageWidth,
            imageHeight: imageHeight,
            text: text
        )
    }
        
}
