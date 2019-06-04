//
//  MainFlowCoordinator.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class MainFlowCoordinator: NSObject, FlowCoordinator {
    
    let window: UIWindow
    let services: ServicesProvider
    
    var navigationController: UINavigationController? {
        return window.rootViewController as? UINavigationController
    }
    
    var mapViewController: MapViewController? {
        return self.navigationController?.viewControllers.first as? MapViewController
    }
    
    init(window: UIWindow, services: ServicesProvider) {
        self.window = window
        self.services = services
    }
    
    func start() {
        self.mapViewController?.mapDataSource = VenuesLoader(api: self.services.networkingService)
    }
}
