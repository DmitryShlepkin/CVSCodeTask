//
//  NetworkManagerMock.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import Foundation
@testable import CVSCodeTask

class NetworkManagerMock: NetworkManagable {
    
    var response: FlickrImages
    
    init(response: FlickrImages) {
        self.response = response
    }
    
    func request<T>(url urlString: String, parameters: [String : String]?, as type: T.Type) async throws -> T? where T : Decodable, T : Encodable {
        response as? T
    }
    
}

class NetworkManagerWithErrorMock: NetworkManagable {
    
    func request<T>(url urlString: String, parameters: [String : String]?, as type: T.Type) async throws -> T? where T : Decodable, T : Encodable {
        throw NetworkManager.NetworkError.statusCode(statusCode: 500)
    }
    
}
