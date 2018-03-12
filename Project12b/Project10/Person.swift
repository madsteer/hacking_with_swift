//
//  Person.swift
//  Project10
//
//  Created by Cory Steers on 3/9/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit

class Person: NSObject {

    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
