//
//  Capital.swift
//  Project19
//
//  Created by Cory Steers on 4/6/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var favorite: Bool

    init(title: String, coordinate: CLLocationCoordinate2D, info: String, favorite: Bool) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.favorite = favorite
    }
}
