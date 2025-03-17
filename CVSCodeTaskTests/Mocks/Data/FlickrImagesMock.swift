//
//  FlickrImageMock.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

@testable import CVSCodeTask

class FlickrImagesMock {
    
    static var list: FlickrImages {
        FlickrImages(items: [
            getFlickrImage(),
            getFlickrImage(),
            getFlickrImage()
        ])
    }
    
    static var empty: FlickrImages {
        FlickrImages(items: [])
    }
    
    private static func getFlickrImage() -> FlickrImage {
        .init(
            title: nil,
            link: nil,
            media: .init(m: nil),
            date_taken: nil,
            description: nil,
            published: nil,
            author: nil,
            author_id: nil,
            tags: nil
        )
    }
    
}
