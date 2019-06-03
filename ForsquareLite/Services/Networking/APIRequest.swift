//
//  APIRequest.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

enum APIRequestMethod {
    case GET
    case POST
}

protocol APIRequest {
    var path: String { get }
    var method: APIRequestMethod { get }
    var queryParameters: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var parser: APIParser { get }
}
