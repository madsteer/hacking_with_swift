//
//  ViewController.swift
//  Project19
//
//  Created by Cory Steers on 4/6/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Type", style: .plain, target: self, action: #selector(changeMapType))

        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                             info: "Home to the 2012 Summer Olympics.", favorite: false)
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75),
                           info: "Founded over a thousand years ago.", favorite: false)
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508),
                            info: "Often called the City of Light.", favorite: false)
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5),
                           info: "Has a whole country inside it.", favorite: false)
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667),
                                 info: "Named after George himself.", favorite: false)

        mapView.addAnnotation(london)
        mapView.addAnnotation(oslo)
        mapView.addAnnotation(paris)
        mapView.addAnnotation(rome)
        mapView.addAnnotation(washington)
    }

    @objc private func changeMapType() {
        let ac = UIAlertController(title: "Change Map View Type", message: nil, preferredStyle: .alert)   // .actionSheet
        ac.addAction(UIAlertAction(title: "Satelite View", style: .default) { [unowned self] _ in
            self.mapView.mapType = .satellite
        })
        ac.addAction(UIAlertAction(title: "Transit View", style: .default) { [unowned self] _ in
            self.mapView.mapType = .standard
        })
        ac.addAction(UIAlertAction(title: "Hybrid View", style: .default) { [unowned self] _ in
            self.mapView.mapType = .hybrid
        })
        present(ac, animated: true)
    }

    internal func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        let identifier = "Capital"
        // 2, 7
        guard annotation is Capital else { return nil }
        let capital = annotation as! Capital
        // 3
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            // 6
            let pinAnnotationView = annotationView as! MKPinAnnotationView
            pinAnnotationView.annotation = annotation
            pinAnnotationView.pinTintColor = capital.favorite ? .green : pinAnnotationView.pinTintColor
            return pinAnnotationView
        }
        //4
        let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        pinAnnotationView.canShowCallout = true
        pinAnnotationView.pinTintColor = capital.favorite ? .green : pinAnnotationView.pinTintColor
        // 5
        let btn = UIButton(type: .detailDisclosure)
        pinAnnotationView.rightCalloutAccessoryView = btn

        return pinAnnotationView
    }

    internal func mapView(_ mapView: MKMapView,
                          annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        if let annotation = view.annotation {
            let capital = view.annotation as! Capital
            let placeName = capital.title
            let placeInfo = capital.info
            let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            ac.addAction(UIAlertAction(title: "Favoriate?", style: .destructive) { [unowned self, capital, annotation] _ in
                capital.favorite = !capital.favorite
                self.mapView.removeAnnotation(annotation)
                self.mapView.addAnnotation(annotation)
            })
            present(ac, animated: true)
        }
    }
}

