//
//  NetworkError.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

enum NetworkError: Error, Equatable {
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
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.serverError(let lhsCode), .serverError(let rhsCode)):
            return lhsCode == rhsCode
        case (.decodingError, .decodingError):
            return true
        case (.networkFailure(let lhsError as NetworkError), .networkFailure(let rhsError as NetworkError)):
            return lhsError == rhsError
        case (.networkFailure(let lhsError), .networkFailure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
