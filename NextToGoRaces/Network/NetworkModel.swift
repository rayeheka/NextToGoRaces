//
//  NetworkModel.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case serverError(statusCode: Int)
    case decodingError
    case networkFailure(Error)
    
    var errorDescription: String {
        switch self {
        case.invalidURL:
            return "The URL is wrong."
        case .serverError:
            return "Server Error"
        case .decodingError:
            return "Response is not supported."
        case .networkFailure(let error):
            return "Network Failed: \(error.localizedDescription)"
        }
    }
}
