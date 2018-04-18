//
//  ViewController.swift
//  Project21
//
//  Created by Cory Steers on 4/18/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain,
                                                           target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain,
                                                            target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
    }
    
    @objc func scheduleLocal() {
    }

}

