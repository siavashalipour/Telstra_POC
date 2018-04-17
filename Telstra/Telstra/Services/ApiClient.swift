//
//  ApiClient.swift
//  Telstra
//
//  Created by Siavash on 17/4/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case genericError(description: String)
    case jsonEncodingError
}

enum ApiEnvironment: String {
    case dev = "dev"
    case prod = "prod"
}
enum ApiHttpMethodType: String {
    case post = "POST"
    case get = "GET"
    case patch = "PATCH"
    case delete = "DELETE"
}
struct ApiObject {
    let baseUrl: URL? = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
    let env: ApiEnvironment = .dev
    let basePath: String // directory like /auth
    let path: String? //  for example (/register)
    let type: ApiHttpMethodType
    let params: [String: Any]?
}

