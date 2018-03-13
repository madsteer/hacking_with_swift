//
//  ViewController.swift
//  Project13
//
//  Created by Cory Steers on 3/13/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var intensity: UISlider!

    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!

    @IBAction func changeFilter(_ sender: Any) {
    }

    @IBAction func save(_ sender: Any) {
    }

    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target:
            self, action: #selector(importPicture))

        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }

    @objc private func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

        applyProcessing()
    }

    func applyProcessing() {
        currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from:
                                             currentFilter.outputImage!.extent) {

            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
    }
}

