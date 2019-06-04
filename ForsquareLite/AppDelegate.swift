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
    var mainFlowCoordinator: MainFlowCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let environment = Environment(.production)
        self.services = ServicesBuilder.buildServices(environment: environment)
        
        self.mainFlowCoordinator = MainFlowCoordinator(window: self.window ?? UIWindow(),
                                                       services: self.services)
        self.mainFlowCoordinator?.start()
        
        return true
    }

}

