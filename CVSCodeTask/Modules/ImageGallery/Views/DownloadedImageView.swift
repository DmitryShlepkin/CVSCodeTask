//
//  DownloadedImageView.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import SwiftUI

struct DownloadedImageVew: View {
    
    @StateObject private var viewModel = DownloadedImageViewModel()
    
    private let url: String?
    private var center = (UIScreen.main.bounds.width / 2) + 110
    private let animation: Animation = .linear(duration: 2).delay(CGFloat.random(in: 0.1...0.8))
        
    init(url: String?) {
        self.url = url
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                Color.black.opacity(viewModel.isLoading ? 0.2 : 0.4)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 100)
                    .background(Color.gray)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 100)
            .onAppear() {
                Task { [self] in
                    try await self.viewModel.download(url: url)
                }
            }
            .animation(viewModel.isLoading ? animation.repeatForever(autoreverses: true) : nil, value: viewModel.isLoading)
    }
    
}

#Preview {
    DownloadedImageVew(
        url: "https://live.staticflickr.com/65535/54363157654_7ffccd0546_m.jpg"
    )
}
