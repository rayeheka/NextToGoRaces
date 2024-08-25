//
//  ServiceEndpointProtocol.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

protocol ServiceEndpointProtocol {
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var headers: [String: String]? { get }
    
    var urlQueryParams: [String: String]? { get }
}

extension ServiceEndpointProtocol {
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var urlQueryParams: [String: String]? {
        nil
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
