//
//  ViewController.swift
//  DontBullyMe
//
//  Created by Owner on 27/09/15.
//  Copyright © 2015 WecTeam. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // Objects
    var locationManager: CLLocationManager = CLLocationManager() // objects that tracks of the user's location changes
    var userLocation: CLLocation!
    
    // User Interface: UI objects
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        mapView.setCenterCoordinate(newLocation.coordinate, animated: true)
        let viewRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 500, 500)
        mapView.setRegion(viewRegion, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error!")
    }
}