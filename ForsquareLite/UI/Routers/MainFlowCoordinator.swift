//
//  MainFlowCoordinator.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

protocol MainFlowCoordinatorDependencyProvider: class {
    func createDetailsViewController(forVenue venue: Venue,
                                     router: RestaurantDetailsRouter) -> UIViewController
    @discardableResult func enrichMapViewController(_ viewController: MapViewController, router: MapRouter) -> UIViewController
}

class MainFlowCoordinator: NSObject, FlowCoordinator {
    
    let window: UIWindow
    let dependencyProvider: MainFlowCoordinatorDependencyProvider
    
    var navigationController: UINavigationController? {
        return window.rootViewController as? UINavigationController
    }
    
    var mainStoryboard: UIStoryboard? {
        return navigationController?.storyboard
    }
    
    var mapViewController: MapViewController {
        
        guard let mapViewController = self.navigationController?.viewControllers.first as? MapViewController else {
            fatalError("Root view controller is not MapViewController")
        }
        return mapViewController
    }
    
    init(window: UIWindow,
         dependencyProvider: MainFlowCoordinatorDependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        
        self.dependencyProvider.enrichMapViewController(self.mapViewController, router: self)
    }
}

extension MainFlowCoordinator: MapRouter {
    func openDetailsForVenue(_ venue: Venue) {
        
        let detailsViewController = self.dependencyProvider.createDetailsViewController(forVenue: venue,
                                                             router: self)
        
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension MainFlowCoordinator: RestaurantDetailsRouter {
    func openURL(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
