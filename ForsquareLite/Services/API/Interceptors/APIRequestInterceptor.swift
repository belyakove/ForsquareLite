//
//  APIRequestInterceptor.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

typealias PreprocessRequestCompletionBlock = (APIRequest) -> Void

protocol APIRequestInterceptor {
    func shouldPreprocessRequest(_ request: APIRequest) -> Bool
    func preporcessRequest(_ request: APIRequest)
}
