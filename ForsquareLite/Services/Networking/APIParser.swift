//
//  APIParser.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

protocol APIParser {
    func parse(jsonObject :[String: Any]) -> Any?
}
