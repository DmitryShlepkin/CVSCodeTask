//
//  ImageGridView.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import SwiftUI

struct ImageGridView: View {
    
    var images: [FlickrImage]
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Namespace private var namespace
    
    private var columns: [GridItem] {
        let count = horizontalSizeClass == .regular ? 4 : 3
        return Array(repeating: GridItem(.flexible(), spacing: 16), count: count)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(images) { image in
                    NavigationLink {
                        ImageDetailsView(flickrImage: image, namespace: namespace)
                    } label: {
                        DownloadedImageVew(url: image.media?.m)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .accessibilityLabel("Photo of \(image.title ?? "unknown")")
                            .accessibilityHint("Tap to view details")
                            .accessibilityAddTraits(.isButton)
                            .matchedTransitionSource(id: image, in: namespace)
                    }
                }
            }
            .padding(16)
            .accessibilityLabel("Search Results")
        }
    }
    
}

#Preview {
    ImageGridView(images: [
        .init(title: nil, link: "1", media: .init(m: "https://live.staticflickr.com/65535/51052223388_af2e102741_m.jpg"), date_taken: nil, description: nil, published: nil, author: nil, author_id: nil, tags: nil),
        .init(title: nil, link: "2", media: .init(m: "https://live.staticflickr.com/65535/54374180179_4892e3e3fa_m.jpg"), date_taken: nil, description: nil, published: nil, author: nil, author_id: nil, tags: nil),
        .init(title: nil, link: "3", media: .init(m: "https://live.staticflickr.com/65535/54374217968_a2e1a21c1e_m.jpg"), date_taken: nil, description: nil, published: nil, author: nil, author_id: nil, tags: nil),
        .init(title: nil, link: "4", media: .init(m: "https://live.staticflickr.com/65535/54370151182_9348ac96d3_m.jpg"), date_taken: nil, description: nil, published: nil, author: nil, author_id: nil, tags: nil),
    ])
    .environment(\.horizontalSizeClass, .compact)
}
