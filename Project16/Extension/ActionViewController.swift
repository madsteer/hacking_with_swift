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


        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name:
            Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name:
            Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext!.completeRequest(returningItems: [item])
    }

    @objc private func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == Notification.Name.UIKeyboardWillHide {
            script.contentInset = UIEdgeInsets.zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height,
                                               right: 0)
        }
        script.scrollIndicatorInsets = script.contentInset
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
}
