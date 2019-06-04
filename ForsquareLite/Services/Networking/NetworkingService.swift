//
//  NetworkingService.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

typealias NetworkRequestCompletionBlock = (Any?, Error?) -> Void

protocol NetworkingService {
    @discardableResult func executeRequest(_ request: APIRequest,
                                           completionBlock: NetworkRequestCompletionBlock?) -> Cancellable?
}
