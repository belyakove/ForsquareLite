//
//  MainAssembly.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class MainAssembly: NSObject, MainFlowCoordinatorDependencyProvider {
    
    let storyboard: UIStoryboard
    let servicesProvider: ServicesProvider
    
    init(storyboard: UIStoryboard, servicesProvider: ServicesProvider) {
        self.storyboard = storyboard
        self.servicesProvider = servicesProvider
    }
    
    func enrichMapViewController(_ viewController: MapViewController, router: MapRouter) -> UIViewController {
        let dataSource = VenuesLoader(api: self.servicesProvider.networkingService)
        let repository = VenuesRepository()
        
        let mapInteractor = MapInteractorImpl(dataSource: dataSource,
                                              repository: repository,
                                              router: router)
        let mapPresenter = MapPresenterImpl(interactor: mapInteractor)
        mapPresenter.view = viewController
        viewController.presenter = mapPresenter
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        return viewController
    }
    
    func createDetailsViewController(forVenue venue: Venue,
                                     router: RestaurantDetailsRouter) -> UIViewController {
        guard let detailsViewController = self.storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? RestaurantDetailsViewController else {
            fatalError("failed to create RestaurantDetailsViewController")
        }
        
        let repository = RestaurantDetailsRepository(venue: venue)
        let detailsInteractor = RestaurantDetailsInteractorImpl(api: self.servicesProvider.networkingService,
                                                                repository: repository,
                                                                router: router)
        let detailsPresenter = RestaurantDetailsPresenterImpl(interactor: detailsInteractor)
        detailsPresenter.view = detailsViewController
        detailsViewController.presenter = detailsPresenter

        return detailsViewController
    }
}
