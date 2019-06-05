//
//  AnnotationsHelper.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit
import MapKit

class AnnotationsHelper: NSObject {
    
    let mapView: MKMapView
    
    private var currentAnnotations = Set<RestaurantAnnotation>()

    init(mapView: MKMapView) {
        self.mapView = mapView
    }
    
    func clearAllAnnotations() {
        self.mapView.removeAnnotations(Array(self.currentAnnotations))
        self.currentAnnotations.removeAll()
    }
    
    func updateMapAnnotationsForVenues(_ venues: [VenueViewModel]) {
        let annotations = self.annotations(forVenues: venues)
        self.updateAnnotations(annotations)
    }
    
    private func annotations(forVenues venues: [VenueViewModel]) -> Set<RestaurantAnnotation> {
        var annotations = Set<RestaurantAnnotation>()
        for venue in venues {
            let annotation = RestaurantAnnotation(venue: venue)
            annotations.insert(annotation)
        }
        return annotations
    }
    
    private func updateAnnotations(_ annotations:Set<RestaurantAnnotation>) {
        
        let before = self.currentAnnotations
        let after = annotations
        
        let toKeep = before.intersection(after)
        let toAdd = after.subtracting(toKeep)
        let toRemove = before.subtracting(after)
        
        self.currentAnnotations = toKeep.union(toAdd)
        
        self.mapView.addAnnotations(Array(toAdd))
        self.mapView.removeAnnotations(Array(toRemove))
    }

}
