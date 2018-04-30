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

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse,
            CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self),
            CLLocationManager.isRangingAvailable() {
            startScanning()
        }
    }

    private func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid,
                                          major: 123, minor: 456, identifier: "MyBeacon")
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }

    private func update(distance: CLProximity) {
        UIView.animate(withDuration: 0.8) { [unowned self] in
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                self.distanceReading.text = "UNKNOWN"
            case .far:
                self.view.backgroundColor = UIColor.blue
                self.distanceReading.text = "FAR"
            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceReading.text = "NEAR"
            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceReading.text = "RIGHT HERE"
            }
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didRangeBeacons beacons: [CLBeacon],
                         in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
}

