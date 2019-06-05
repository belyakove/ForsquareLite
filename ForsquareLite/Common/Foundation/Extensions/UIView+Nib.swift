//
//  UIView+Nib.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

extension UIView {
    static func viewFromNib<T: UIView>() -> T {
        guard let view = Bundle.main.loadNibNamed(String(describing: self), owner: self, options: nil)?.first as? T else {
            fatalError("Failed to load \(self) from nib file")
        }
        return view
    }
}
