//
//  ImageGalleryView.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import SwiftUI

struct ImageGalleryView: View {
    
    @StateObject private var viewModel = ImageGalleryViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .initial, .empty, .error:
                    MessageView(
                        title: viewModel.message?.title ?? "",
                        description: viewModel.message?.description ?? ""
                    )
                case .loading, .success:
                    ImageGridView(images: viewModel.images)
                }
            }
            .navigationTitle("Flickr")
            .searchable(text: $searchText, prompt: "Search")
            .onChange(of: searchText) {
                Task {
                    try await viewModel.search(query: searchText)
                }
            }
            .overlay {
                if viewModel.state == .loading {
                    LoadingView()
                }
            }
        }
    }
    
}

#Preview {
    ImageGalleryView()
}
