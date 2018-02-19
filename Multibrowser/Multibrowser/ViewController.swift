//
//  ViewController.swift
//  Multibrowser
//
//  Created by Cory Steers on 1/9/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var addressBar: UITextField!
    
    @IBOutlet weak var stackView: UIStackView!
    
    private func setDefaultTitle() {
        title = "Multibrowser"
    }
    
    @objc private func addWebView() {
        let webView = UIWebView()
        webView.delegate = self
        stackView.addArrangedSubview(webView)
        let url = URL(string: "https://www.hackingwithswift.com")!
        
//        DispatchQueue.global(qos: .userInitiated).async {
            webView.loadRequest(URLRequest(url: url))
            /*
            DispatchQueue.main.async {
                // anything needed here?
            }
            */
//        }
    }
    
    @objc private func deleteWebView() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultTitle()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target:
            self, action: #selector(addWebView))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash,
                                     target: self, action: #selector(deleteWebView))
        navigationItem.rightBarButtonItems = [delete, add]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

