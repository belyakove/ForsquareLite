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
    
    class func withRating(_ rating: Rating) -> RatingView {
        let ratingView = Bundle(for: self).loadNibNamed("RatingView", owner: nil, options: nil)?.first as? RatingView
        
        ratingView?.rating = rating
        
        return ratingView ?? RatingView()
    }
    
    var rating: Rating? {
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
