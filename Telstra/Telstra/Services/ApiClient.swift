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

struct ApiObject {
    let baseUrl: URL? = URL(string: Constant.urlString)
}

