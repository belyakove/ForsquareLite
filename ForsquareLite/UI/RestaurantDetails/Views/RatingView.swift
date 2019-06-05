//
//  RatingView.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class RatingView: UIView {

    @IBOutlet weak var label: UILabel!
    
    class func withRating(_ rating: RatingViewModel) -> RatingView {
        let ratingView: RatingView = RatingView.viewFromNib()
        ratingView.rating = rating
        return ratingView
    }
    
    var rating: RatingViewModel? {
        didSet {
            
            if let rating = self.rating {
                self.label.text = "Rating: \(rating.rating)"
                if let color = rating.ratingColor {
                    self.label.textColor = color
                }
                
            } else {
                self.label.text = nil
            }
            
        }
    }
    
}
