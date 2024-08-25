//
//  RacesServiceEndpoint.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

struct RacesServiceEndpoint: ServiceEndpointProtocol {
    var numberOfNextRaces: Int
    
    var path: String = "v1/racing/"
    var httpMethod: HTTPMethod = .get
    var urlQueryParams: [String : String]? {
        return [
            "method": "nextraces",
            "count": "\(numberOfNextRaces)"
        ]
    }
}
