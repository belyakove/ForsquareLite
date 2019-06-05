//
//  PhotoView.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    class func withPhotoURL(_ photoURL: URL) -> PhotoView {
        
        let photoView: PhotoView = PhotoView.viewFromNib()
        photoView.photoURL = photoURL
        
        return photoView
    }
    
    var photoURL: URL? {
        didSet {
            if let url = self.photoURL {
                self.imageView.af_setImage(withURL: url)
            } else {
                self.imageView.image = nil
            }
        }
    }
    
    override func awakeFromNib() {
        self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
}
