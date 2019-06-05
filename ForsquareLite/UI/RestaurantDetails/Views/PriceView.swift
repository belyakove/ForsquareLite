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

    class func withPrice(_ price: PriceViewModel) -> PriceView {
        let priceView: PriceView = PriceView.viewFromNib()
        priceView.price = price
        return priceView
    }

    var price: PriceViewModel? {
        didSet {
            if let price = self.price {
                priceTagLabel.text = price.pricing
                priceDescriptionLabel.text = price.message
            } else {
                priceTagLabel.text = nil
                priceDescriptionLabel.text = nil
            }
        }
    }
    
}
