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
    var mainAssembly: MainAssembly!

    var mainStoryboard: UIStoryboard {
        guard let storyboard = self.window?.rootViewController?.storyboard else {
            fatalError("No main storyboard present")
        }
        return storyboard
    }
    
    var mainWindow: UIWindow {
        guard let window = self.window else {
            fatalError("No main window present")
        }
        return window
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let environment = Environment(.production)
        self.services = ServicesBuilder.buildServices(environment: environment)
        
        self.mainAssembly = MainAssembly(storyboard: self.mainStoryboard,
                                         servicesProvider: self.services)
        
        self.mainFlowCoordinator = MainFlowCoordinator(window: self.mainWindow,
                                                       dependencyProvider: self.mainAssembly)
        self.mainFlowCoordinator?.start()
        
        return true
    }

}

