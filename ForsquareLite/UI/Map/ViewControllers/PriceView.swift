//
//  PriceView.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class PriceView: UIView {

    @IBOutlet weak var priceTagLabel: UILabel!
    @IBOutlet weak var priceDescriptionLabel: UILabel!

    class func withPrice(_ price: Price) -> PriceView {
        let priceView = Bundle(for: self).loadNibNamed("PriceView", owner: nil, options: nil)?.first as? PriceView
        
        priceView?.price = price
        return priceView ?? PriceView()
    }

    var price: Price? {
        didSet {
            if let price = self.price {
                
                var tagString: String = String()
                
                for _ in 0..<price.tier {
                    tagString.append(contentsOf: price.currency)
                }
                
                priceTagLabel.text = tagString
                priceDescriptionLabel.text = price.message
            } else {
                priceTagLabel.text = nil
                priceDescriptionLabel.text = nil
            }
        }
    }
    
}
