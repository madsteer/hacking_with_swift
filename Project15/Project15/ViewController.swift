//
//  ViewController.swift
//  Project15
//
//  Created by Cory Steers on 3/26/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!
    var currentAnimation = 0

    @IBOutlet var tap: UIButton!

    @IBAction func tapped(_ sender: UIButton) {
        tap.isHidden = true

        UIView.animate(withDuration: 1, delay: 0, options: [], animations: { [unowned self] in
            switch self.currentAnimation {
            case 0: break
            default:
                break
            }
        }) { [unowned self] (finished: Bool) in
            self.tap.isHidden = false
        }

        currentAnimation = currentAnimation > 6 ? 0 : currentAnimation + 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }
}

