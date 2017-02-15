//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Tyler Bailey on 2/4/17.
//  Copyright © 2017 Tyler Bailey. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var mapView: MKMapView!
    
    override func loadView(){
        
        mapView = MKMapView()
        view = mapView
        
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
        
        
        let locateMeButton = UIButton(frame: CGRect(x: 20, y: 70, width: 100, height: 30))
        locateMeButton.backgroundColor = .blue
        locateMeButton.alpha = 0.7
        locateMeButton.layer.cornerRadius = 5
        locateMeButton.layer.borderWidth = 1
        locateMeButton.layer.borderColor = UIColor.blue.cgColor
        locateMeButton.addTarget(self, action: #selector(locateMeButtonTapped), for: .touchUpInside)
        locateMeButton.setTitle("Locate Me", for: .normal)
        view.addSubview(locateMeButton)
        
        let pinButton = UIButton(frame: CGRect(x: 250, y: 70, width: 100, height: 30))
        pinButton.backgroundColor = .blue
        pinButton.alpha = 0.7
        pinButton.layer.cornerRadius = 5
        pinButton.layer.borderWidth = 1
        pinButton.layer.borderColor = UIColor.blue.cgColor
        pinButton.addTarget(self, action: #selector(pinButtonTapped), for: .touchUpInside)
        pinButton.setTitle("Pin", for: .normal)
        view.addSubview(pinButton)
        
        
    }
    
    func locateMeButtonTapped(button: UIButton)
    {
    
        
    }
    func pinButtonTapped(button: UIButton)
    {
        
        
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            print(" MapViewController loaded its view.")
        
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        
        switch segControl.selectedSegmentIndex
        {
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
