//
//  CVSCodeTaskApp.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import SwiftUI

@main
struct CVSCodeTaskApp: App {
    
    init() {
        registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            ImageGalleryView()
        }
    }
    
    private func registerDependencies() {
        DependencyManager.register(type: NetworkManagable.self, NetworkManager())
        DependencyManager.register(type: ImageManagable.self, ImageManager())
    }
    
}
