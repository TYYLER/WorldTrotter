//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Tyler Bailey on 2/4/17.
//  Copyright © 2017 Tyler Bailey. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate
{
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var locateMeBool:Bool = true
    var pinNum:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView(){
        mapView = MKMapView()
        view = mapView
        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        
        mapView.showsUserLocation = true

        setupPins()
        setupSegmentedControl()
        setupLocateMeButton()
        setupPinButton()
    }
    
    func setupPins()
    {
        let hpu = MKPointAnnotation()
        let home = MKPointAnnotation()
        let peir = MKPointAnnotation()
        
        hpu.coordinate = CLLocationCoordinate2DMake(35.973233, -79.995040)
        home.coordinate = CLLocationCoordinate2DMake(38.920939, -76.581784)
        peir.coordinate = CLLocationCoordinate2DMake(26.131555, -81.807494)
        
        mapView.addAnnotation(hpu)
        mapView.addAnnotation(home)
        mapView.addAnnotation(peir)
    }
    
    func setupLocateMeButton()
    {
        let locateMeButton = UIButton(frame: CGRect(x: 20, y: 580, width: 100, height: 30))
        locateMeButton.backgroundColor = .blue
        locateMeButton.alpha = 0.7
        locateMeButton.layer.cornerRadius = 5
        locateMeButton.layer.borderWidth = 1
        locateMeButton.addTarget(self, action: #selector(MapViewController.locateMeButtonTapped(button:)), for: .touchUpInside)
        locateMeButton.setTitle("Locate Me", for: .normal)
        view.addSubview(locateMeButton)
    }
    
    func setupPinButton()
    {
        let pinButton = UIButton(frame: CGRect(x: 250, y: 580, width: 100, height: 30))
        pinButton.backgroundColor = .blue
        pinButton.alpha = 0.7
        pinButton.layer.cornerRadius = 5
        pinButton.layer.borderWidth = 1
        pinButton.addTarget(self, action: #selector(pinButtonTapped), for: .touchUpInside)
        pinButton.setTitle("Pin 1", for: .normal)
        view.addSubview(pinButton)
    }
    
    func setupSegmentedControl()
    {
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        
        let segmentedControl = UISegmentedControl( items: [standardString, satelliteString, hybridString])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent( 0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget( self, action: #selector( MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview( segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint( equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint( equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint( equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    func locateMeButtonTapped(button: UIButton)
    {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
        //Locating User
        if locateMeBool == true{
            mapView.setUserTrackingMode(.follow,animated: true)
        
            button.setTitle("Default", for: .normal)
            locateMeBool = false
        }
        //Original location
        else{
            
            button.setTitle("Locate Me", for: .normal)
            locateMeBool = true
        }
        
    }
    
    func pinButtonTapped(button: UIButton)
    {
        var center : CLLocationCoordinate2D!
        var region : MKCoordinateRegion!
        
        //Pin 1
        if pinNum == 0 {
            center = CLLocationCoordinate2DMake(35.973233, -79.995040)
            region = MKCoordinateRegionMakeWithDistance(center, 500.0, 500.0)
            mapView.setRegion(region, animated: true)
            
            button.setTitle("Pin 2", for: .normal)
            pinNum = 1
        }
        //Pin 2
        else if pinNum == 1 {
            center = CLLocationCoordinate2DMake(38.920939, -76.581784)
            region = MKCoordinateRegionMakeWithDistance(center, 500.0, 500.0)
            mapView.setRegion(region, animated: true)
            
            button.setTitle("Pin 3", for: .normal)
            pinNum = 2
        }
        //Pin 3
        else {
            center = CLLocationCoordinate2DMake(26.131555, -81.807494)
            region = MKCoordinateRegionMakeWithDistance(center, 500.0, 500.0)
            mapView.setRegion(region, animated: true)
            
            button.setTitle("Pin 1", for: .normal)
            pinNum = 0
        }
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default: break
        }
    }
}
