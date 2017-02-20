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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(" MapViewController loaded its view.")
        
    }
    override func loadView(){
        
        mapView = MKMapView()
        locationManager = CLLocationManager()
        view = mapView
        locationManager.requestAlwaysAuthorization()
        
        setupSegmentedControl()
        setupLocateMeButton()
        setupPinButton()
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
    
    var locateMeBool:Bool = true
    func locateMeButtonTapped(button: UIButton)
    {
        print("Locate Me Button Tapped")
        
        if locateMeBool == true{
            print(" Locating User")
        
            locationManager.requestWhenInUseAuthorization()
            
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(.follow,animated: true)

            button.setTitle("Default", for: .normal)
            locateMeBool = false
        }
        else{
            print(" Original Location")
            
            mapView.showsUserLocation = false
            
            button.setTitle("Locate Me", for: .normal)
            locateMeBool = true
        }
        
    }
    
    var pinNum:Int = 0
    func pinButtonTapped(button: UIButton)
    {
        print("Pin Button Tapped")
        if pinNum == 0 {
            print(" Pin 1")
            button.setTitle("Pin 2", for: .normal)
            pinNum = 1
        }
        else if pinNum == 1 {
            print(" Pin 2")
            button.setTitle("Pin 3", for: .normal)
            pinNum = 2
        }
        else {
            print(" Pin 3")
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
