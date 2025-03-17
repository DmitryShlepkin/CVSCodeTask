//
//  Untitled.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import Testing
@testable import CVSCodeTask

struct ImageGalleryViewModelTest {
 
    @MainActor @Test("search(success)") func testSearch_givenSuccessResponse_expectStateToBeSuccess() async throws {
        let networkManagerMock = NetworkManagerMock(response: FlickrImagesMock.list)
        DependencyManager.register(type: NetworkManagable.self, networkManagerMock, update: true)
        let sut = ImageGalleryViewModel()
        do {
            try await sut.search(query: "test")
            try await Task.sleep(for: .seconds(3))
        } catch {
            throw error
        }
        #expect(sut.state == .success)
        #expect(sut.images.count == 3)
    }

    @MainActor @Test("search(empty)") func testSearch_givenEmptyResponse_expectStateToBeEmpty() async throws {
        let networkManagerMock = NetworkManagerMock(response: FlickrImagesMock.empty)
        DependencyManager.register(type: NetworkManagable.self, networkManagerMock, update: true)
        let sut = ImageGalleryViewModel()
        do {
            try await sut.search(query: "test")
            try await Task.sleep(for: .seconds(3))
        } catch {
            throw error
        }
        #expect(sut.state == .empty)
        #expect(sut.images.count == 0)
        #expect(sut.message?.title == "Not found")
        #expect(sut.message?.description == "Please update your search query.")
    }

    @MainActor @Test("search(error)") func testSearch_givenErrorResponse_expectStateToBeError() async throws {
        let networkManagerMock = NetworkManagerWithErrorMock()
        DependencyManager.register(type: NetworkManagable.self, networkManagerMock, update: true)
        let sut = ImageGalleryViewModel()
        do {
            try await sut.search(query: "test")
            try await Task.sleep(for: .seconds(3))
        } catch {
            throw error
        }
        #expect(sut.state == .error)
        #expect(sut.images.count == 0)
        #expect(sut.message?.title == "Error")
        #expect(sut.message?.description == "Please try again later.")
    }

    @MainActor @Test("default message") func testMessage_givenInitialState_expectMessageToBeInitialMessage() async throws {
        let sut = ImageGalleryViewModel()
        #expect(sut.message?.title == "Welcome!")
        #expect(sut.message?.description == "Please enter search keywords above.")
    }

}
