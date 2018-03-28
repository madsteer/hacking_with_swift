//
//  ActionViewController.swift
//  Extension
//
//  Created by Cory Steers on 3/28/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet var script: UITextView!

    var pageTitle = ""
    var pageURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first as?
                NSItemProvider {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) {
                    [unowned self] (dict, error) in

                    let itemDictionary = dict as! NSDictionary
                    let javaScriptValues =
                        itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
//                    print(javaScriptValues)
                    self.pageTitle = javaScriptValues["title"] as! String
                    self.pageURL = javaScriptValues["URL"] as! String

                    DispatchQueue.main.async { // use [unowned self] from outer closure above
                        self.pageTitle = self.pageTitle
                    }
                }
            }
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                            action: #selector(done))
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext!.completeRequest(returningItems: [item])
    }

}
