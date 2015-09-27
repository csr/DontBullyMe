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
    var searchController: UISearchController!
    var searchResultsTableViewController: UITableViewController!
    @IBOutlet weak var buttonGetLocationToolbar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieving location
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.startUpdatingLocation()
        
        // Search bar stuff
        searchResultsTableViewController = UITableViewController()
        searchResultsTableViewController.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(1.0)
        searchController = UISearchController(searchResultsController: searchResultsTableViewController)
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchBar.placeholder = "Search for places..."
        
        //searchResultsTableViewController.tableView.delegate = self
        //searchResultsTableViewController.tableView.dataSource = self
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
    
    @IBAction func tapOnGetLocation(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: {
            self.buttonGetLocationToolbar.image = UIImage(named: "request1")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension ViewController: UISearchControllerDelegate {
    func willPresentSearchController(searchController: UISearchController) {
        // calculate frame
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let navigationBarFrame = navigationController!.navigationBar.frame
        let tableViewY = navigationBarFrame.height + statusBarHeight
        let tableViewHeight: CGFloat = 30
        
        searchResultsTableViewController.tableView.frame = CGRectMake(0, tableViewY, navigationBarFrame.width, tableViewHeight)
    }
    
    override func viewWillLayoutSubviews() {
    }
    
    func presentSearchController(searchController: UISearchController) {
    }
    
    func didPresentSearchController(searchController: UISearchController) {
    }
}