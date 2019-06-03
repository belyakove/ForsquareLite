//
//  AppDelegate.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var services: ServicesProvider!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let environment = Environment(.production)
        self.services = ServicesBuilder.buildServices(environment: environment)
        
        
        let coordinates = MapCoordinateRect(south: 52.21, west: 4.53, north: 52.23, east: 4.55)
        let request = SearchRequest(coordinateRect: coordinates)
                
        return true
    }

}

