//
//  WebsiteView.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

protocol WebsiteViewDelegate: class {
    func websiteView(_ view: UIView, didRequestOpenURL url: URL)
}

class WebsiteView: UIView {

    weak var delegate: WebsiteViewDelegate?
    
    @IBOutlet weak var button: UIButton!
    
    var url: URL?
    
    class func withURL(_ url: URL, delegate: WebsiteViewDelegate? = nil) -> WebsiteView {
        let websiteView: WebsiteView = WebsiteView.viewFromNib()
        websiteView.url = url
        websiteView.delegate = delegate
        return websiteView
    }
    
    @IBAction func openWebsite() {
        if let url = self.url {
            self.delegate?.websiteView(self, didRequestOpenURL: url)
        }
    }
    
    override func awakeFromNib() {
        self.button.setBackgroundImage(self.createBackgroundImage(), for: .normal)
        self.button.setTitleColor(UIColor.white, for: .normal)
    }
    
    func createBackgroundImage() -> UIImage {
        
        let size = CGSize(width: 60, height: 48)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let bezierPath = UIBezierPath(roundedRect: rect,
                                      cornerRadius: size.height / 2.0)
        UIColor(red: 0.29, green: 0.57, blue: 0.87, alpha: 1.0).setFill()
        bezierPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let resizingInsets = UIEdgeInsets(top: 0.0,
                                          left: size.height/2.0,
                                          bottom: 0.0,
                                          right: size.height/2.0)
        return image?.resizableImage(withCapInsets: resizingInsets) ?? UIImage()
    }
}
