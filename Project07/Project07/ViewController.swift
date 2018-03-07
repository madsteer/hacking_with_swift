//
//  ViewController.swift
//  Project07
//
//  Created by Cory Steers on 3/6/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [[String: String]]()

    var urlStrings = [0: "https://api.whitehouse.gov/v1/petitions.json?limit=100",
                      1: "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    ]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = urlStrings[navigationController?.tabBarItem.tag ?? 0]!

        if let url = URL(string: urlString),
            let data = try? String(contentsOf: url) {

            let json = JSON(parseJSON: data)

            if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                parse(json: json)
                return

//            } else {
//                showError()
            }
//        } else {
//            showError()
        }
        showError()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    private func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            petitions.append(obj)
        }
        tableView.reloadData()
    }

    private func showError() {
        let ac = UIAlertController(title: "Loading error", message:
            "There was a problem loading the feed; please check your connection and try again.",
                                   preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
    }
}

