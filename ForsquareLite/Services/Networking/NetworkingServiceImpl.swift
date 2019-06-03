//
//  NetworkingService.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit
import Alamofire

class NetworkingServiceImpl: NSObject, NetworkingService {
    let sessionManager: Alamofire.SessionManager
    let baseURL: URL
    
    convenience init(baseURL: URL) {
        self.init(configuration: URLSessionConfiguration.default, baseURL: baseURL)
    }
    
    init(configuration: URLSessionConfiguration, baseURL: URL) {
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
        //self.sessionManager.ser
        self.baseURL = baseURL
        super.init()
    }
    
    func executeRequest(_ request: APIRequest, completionBlock: NetworkRequestCompletionBlock?) -> Cancellable? {
        
        guard var urlComponents = URLComponents(url: self.baseURL, resolvingAgainstBaseURL: false) else {
            completionBlock?(nil, URLError(.badURL))
            return nil
        }
        
        urlComponents.path = request.path
        
        if let queryParameters = request.queryParameters {
            let queryItems = queryParameters.map { (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: value)
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let fullURL = urlComponents.url else {
            completionBlock?(nil, URLError(.badURL))
            return nil;
        }
        
        return self.sessionManager.request(fullURL,
                                           method: request.method.httpMethod,
                                           parameters: request.parameters,
                                           encoding: JSONEncoding.default,
                                           headers: request.headers)
            .validate()
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    completionBlock?(response.result.value, response.result.error)
                    return
                }

                guard let resultValue = response.result.value as? [String: Any] else {
                    completionBlock?(nil, URLError(.badServerResponse))
                    return
                }
                
                let resultObject = request.parser.parse(jsonObject: resultValue)
                
                completionBlock?(resultObject, response.result.error)
        }
    }
}

extension APIRequestMethod {
    var httpMethod: HTTPMethod {
        switch self {
        case .GET:
            return HTTPMethod.get
        case .POST:
            return HTTPMethod.post
        }
    }
}

extension Alamofire.DataRequest: Cancellable {
}
