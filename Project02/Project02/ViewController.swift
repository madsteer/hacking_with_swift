//
//  ViewController.swift
//  Project02
//
//  Created by Cory Steers on 2/21/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit
import GameplayKit

private extension NSMutableAttributedString {
    func bold(_ text: String) {
        if let range = self.string.range(of: text) {
            let nsRange = NSRange(range, in: text)
            let newFontSize = CGFloat(UIFont.systemFontSize + 5)
            addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: newFontSize), range: nsRange)
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    var countries = [String]()
    var correctAnswer = 0
    var score: Int = 0 {
        didSet { scoreLabel.attributedText = boldMyText(with: score) }
    }
    
    private func boldMyText(with score: Int) -> NSMutableAttributedString {
        let baseText = "Score:"
        let scoreText = "\(baseText) \(score)"
        let attributedText = NSMutableAttributedString(string: scoreText)
        attributedText.bold(baseText)
        
        return attributedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        setCountries()
        askQuestion()
    }
    
    private func setCountries() {
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
    }
    
    private func askQuestion(action: UIAlertAction! = nil) {
        
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        title = "Which flag is \(countries[correctAnswer].uppercased())?"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if correctAnswer == sender.tag {
            score += 1
            title = "Correct!"
        } else {
            score -= 1
            title = "Wrong!"
        }
        
        // pause
        let deadlineTime = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) { self.askQuestion() }
    }
}

