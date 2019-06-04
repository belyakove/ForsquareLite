//
//  UIColor+Hex.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init?(hexString: String) {
        
        guard hexString.count >= 6 else {
            return nil
        }
        
        let bIndex = hexString.index(hexString.endIndex, offsetBy: -2)
        let gIndex = hexString.index(hexString.endIndex, offsetBy: -4)
        let rIndex = hexString.index(hexString.endIndex, offsetBy: -6)
        
        let bRange = bIndex..<hexString.endIndex
        let gRange = gIndex..<bIndex
        let rRange = rIndex..<gIndex
        
        let bSubstring = hexString[bRange]
        let gSubstring = hexString[gRange]
        let rSubstring = hexString[rRange]
        
        let blue = Int(bSubstring, radix: 16) ?? 0
        let green = Int(gSubstring, radix: 16) ?? 0
        let red = Int(rSubstring, radix: 16) ?? 0
        
        self.init(red: CGFloat(Double(red) / 255),
                  green: CGFloat(Double(green) / 255),
                  blue: CGFloat(Double(blue) / 255),
                  alpha: 1)
    }
}
