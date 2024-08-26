//
//  URLSessionService.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

struct URLSessionService: NetworkServiceProtocol {
    var urlSession: URLSessionProtocol = URLSession.shared
    
    /// Sends a network request to the specified endpoint and decodes the response into the expected type.
    ///
    /// - Parameter endpoint: An object conforming to `ServiceEndpointProtocol` that provides the endpoint details.
    /// - Returns: The decoded response data of the specified type.
    /// - Throws: A `NetworkError` if the request fails, the URL is invalid, or the decoding process encounters an error.
    func request<T: Codable>(endpoint: ServiceEndpointProtocol) async throws -> T {
        guard let urlRequest = createUrlRequest(endpoint: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }
            
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(BaseResponse<T>.self, from: data).data
            } catch {
                throw NetworkError.decodingError
            }
        } catch {
            throw NetworkError.networkFailure(error)
        }
    }
    
    
    private func createUrlRequest(endpoint: ServiceEndpointProtocol) -> URLRequest? {
        guard let url = URL(string: Config.BASE_URL.rawValue + endpoint.path) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        
        endpoint.headers?.forEach({
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        })
        
        guard let urlQueryParams = endpoint.urlQueryParams,
              let encoded = try? JSONEncoder().encode(urlQueryParams),
              let jsonObject = try? JSONSerialization.jsonObject(with: encoded)as? [String: Any],
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            return urlRequest
        }
        urlComponents.queryItems = jsonObject.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        urlRequest.url = urlComponents.url
        return urlRequest
    }
}

extension URLSession: URLSessionProtocol { }
