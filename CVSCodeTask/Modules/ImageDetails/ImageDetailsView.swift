//
//  ImageDetailsView.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import SwiftUI

struct ImageDetailsView: View {
    
    let flickrImage: FlickrImage
    let namespace: Namespace.ID
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                AsyncImage(
                    url: flickrImage.media?.url
                ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: 400)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                }
                .navigationTransition(.zoom(sourceID: flickrImage, in: namespace))
                VStack(alignment: .leading, spacing: 16) {
                    if let title = flickrImage.title {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .dynamicTypeSize(...dynamicTypeSize)
                    }
                    if let description = flickrImage.parsedDescription?.text {
                        Text(description)
                            .font(.title3)
                            .foregroundColor(.primary)
                            .dynamicTypeSize(...dynamicTypeSize)
                    }
                    if let date = flickrImage.formattedDate {
                        Text(date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .dynamicTypeSize(...dynamicTypeSize)
                    }
                    if
                        let imageWidth = flickrImage.parsedDescription?.imageWidth,
                        let imageHeight = flickrImage.parsedDescription?.imageHeight {
                        Text("Image size: \(imageWidth)x\(imageHeight)")
                            .font(.caption)
                            .foregroundColor(.primary)
                            .dynamicTypeSize(...dynamicTypeSize)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareButton(
                    link: flickrImage.parsedDescription?.imagePageLink,
                    title: flickrImage.title ?? "",
                    message: "Check out this photo on Flickr"
                )
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    ImageDetailsView(
        flickrImage: .init(
            title: "PUERCOESPIN HDR",
            link: "https://www.flickr.com/photos/tags/porcupine/",
            media: .init(m: "https://live.staticflickr.com/65535/51052223388_af2e102741_m.jpg"),
            date_taken: "2025-03-14T12:12:12-08:00",
            description: " <p><a href=\"https://www.flickr.com/people/187606811@N08/\">MIGUELITO COYOTE</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/187606811@N08/51052223388/\" title=\"PUERCOESPIN HDR\"><img src=\"https://live.staticflickr.com/65535/51052223388_af2e102741_m.jpg\" width=\"240\" height=\"135\" alt=\"PUERCOESPIN HDR\" /></a></p> <p>Puercoespin HDR COYOTE</p> ",
            published: "2025-03-14T11:12:12Z",
            author: "nobody@flickr.com (\"MIGUELITO COYOTE\")",
            author_id: "187606811@N08",
            tags: "naturaleza nature nikon animals hdr photoshop fotomontaje naturalista canon photo photografy outside fotografia foto coyote colours colores porcupine espa animal animales autumn oto"
        ),
        namespace: namespace
    )
}
