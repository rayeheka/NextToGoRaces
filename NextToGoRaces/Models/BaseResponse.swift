//
//  BaseResponse.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let status: Int
    let data: T
}
