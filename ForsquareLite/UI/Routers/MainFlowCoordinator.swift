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
    
    var mainStoryboard: UIStoryboard? {
        return navigationController?.storyboard
    }
    
    var mapViewController: MapViewController? {
        return self.navigationController?.viewControllers.first as? MapViewController
    }
    
    init(window: UIWindow, services: ServicesProvider) {
        self.window = window
        self.services = services
    }
    
    func start() {
        
        let dataSource = VenuesLoader(api: self.services.networkingService)
        let repository = VenuesRepository()
        
        let mapInteractor = MapInteractorImpl(dataSource: dataSource,
                                              repository: repository,
                                              router: self)
        let mapPresenter = MapPresenterImpl(interactor: mapInteractor)
        mapPresenter.view = self.mapViewController
        mapViewController?.presenter = mapPresenter
        
        self.mapViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension MainFlowCoordinator: MapRouter {
    func openDetailsForVenue(_ venue: Venue) {
        
        guard let detailsViewController = self.mainStoryboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? RestaurantDetailsViewController else {
            return
        }

        let repository = RestaurantDetailsRepository(venue: venue)
        let detailsInteractor = RestaurantDetailsInteractorImpl(api: self.services.networkingService,
                                                                repository: repository,
                                                                router: self)
        let detailsPresenter = RestaurantDetailsPresenterImpl(interactor: detailsInteractor)
        detailsPresenter.view = detailsViewController
        detailsViewController.presenter = detailsPresenter

        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension MainFlowCoordinator: RestaurantDetailsRouter {
    func openURL(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
