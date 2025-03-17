//
//  ImageGalleryViewModel.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import Foundation

final class ImageGalleryViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case success
        case empty
        case error
    }
    
    struct Message {
        let title: String
        let description: String
    }
        
    private let apiURL = "https://api.flickr.com/services/feeds/photos_public.gne"
    private let debounceDelay = 500
    
    @Dependency private var networkManager: NetworkManagable?
    private var searchTask: Task<Void, Error>?
    private var messages: [String: Message] = [
        "\(String(describing: State.initial))": .init(
            title: "Welcome!",
            description: "Please enter search keywords above."
        ),
        "\(String(describing: State.empty))": .init(
            title: "Not found",
            description: "Please update your search query."
        ),
        "\(String(describing: State.error))": .init(
            title: "Error",
            description: "Please try again later."
        )
    ]
            
    @Published var state: State = .initial
    var images: [FlickrImage] = []
    var message: Message? {
        messages["\(state)"]
    }
    var isLoading : Bool {
        state == .loading
    }
    
    func search(query: String) async throws {
        guard query.count > 0 else {
            searchTask?.cancel()
            return
        }
        let task = Task { [searchTask] in
            searchTask?.cancel()
            try await Task.sleep(for: .milliseconds(debounceDelay))
            await updateState(to: .loading)
            do {
                let data = try await networkManager?.request(url: apiURL, parameters: [
                    "format": "json",
                    "nojsoncallback": "1",
                    "tags": query.trimmingCharacters(in: .whitespacesAndNewlines)
                ], as: FlickrImages.self)
                guard let count = data?.items.count else { return }
                if count > 0 {
                    images = data?.items ?? []
                    await updateState(to: .success)
                } else {
                    await updateState(to: .empty)
                }
            } catch {
                await updateState(to: .error)
            }
        }
        searchTask = task
        try await task.value
    }
    
    @MainActor private func updateState(to state: State) {
        self.state = state
    }
    
    deinit {
        searchTask?.cancel()
    }
    
}
