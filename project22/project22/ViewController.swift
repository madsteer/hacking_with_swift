//
//  ViewController.swift
//  project22
//
//  Created by Cory Steers on 4/30/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var distanceReading: UILabel!

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
//        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        view.backgroundColor = UIColor.gray
    }


}

