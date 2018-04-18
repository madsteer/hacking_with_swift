//
//  ViewController.swift
//  Project21
//
//  Created by Cory Steers on 4/18/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain,
                                                           target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain,
                                                            target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }

    @objc func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()

        if let date = Calendar.current.date(byAdding: .minute, value: 1, to: Date()) {

            var dateComponents = DateComponents()
            dateComponents.hour = Calendar.current.component(.hour, from: date)
            dateComponents.minute = Calendar.current.component(.minute, from: date)
            print("date hour: \(String(describing: dateComponents.hour)), date minute: \(String(describing: dateComponents.minute))")
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // do interval instead
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
            print("Scheduled!")
        }
    }

}

