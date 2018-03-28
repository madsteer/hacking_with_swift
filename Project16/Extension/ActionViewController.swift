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
                    print(javaScriptValues)
                }
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
