//
//  ViewController.swift
//  Project08
//
//  Created by Cory Steers on 3/7/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet var cluesLabel: UILabel!
    @IBOutlet var answersLabel: UILabel!
    @IBOutlet var currentAnswer: UITextField!
    @IBOutlet var scoreLabel: UILabel!


    @IBAction func submitTapped(_ sender: Any) {
        if let solutionPosition = solutions.index(of: currentAnswer.text!) {
            activatedButtons.removeAll()
            var splitAnswers = answersLabel.text!.components(separatedBy: "\n")
            splitAnswers[solutionPosition] = currentAnswer.text!
            answersLabel.text = splitAnswers.joined(separator: "\n")
            currentAnswer.text = ""
            score += 1

            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?",
                                           preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        currentAnswer.text = ""
//        activatedButtons.forEach { $0.isHidden = false }
        activatedButtons.forEach { (button: UIButton) in
            button.isHidden = true
            UIView.animate(withDuration: 3, delay: 0, options: [], animations: {
                button.alpha = 1
                button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                button.transform = CGAffineTransform.identity
            })
            { (finished: Bool) in
                button.isHidden = false
            }
        }
        activatedButtons.removeAll()
    }

    private var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    private func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
//        letterButtons.forEach { $0.isHidden = false }
        letterButtons.forEach { (button: UIButton) in
            button.isHidden = true
            UIView.animate(withDuration: 3, delay: 0, options: [], animations: {
                button.alpha = 1
                button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                button.transform = CGAffineTransform.identity
            })
            { (finished: Bool) in
                button.isHidden = false
            }
        }
    }

    private func loadLevel() {
        currentAnswer.text = initialGuess
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()

        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt"),
            let levelContents = try? String(contentsOfFile: levelFilePath) {
            var lines = levelContents.components(separatedBy: "\n")
            lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
            for (index, line) in lines.enumerated() {
                let parts = line.components(separatedBy: ": ")
                let answer = parts[0]
                let clue = parts[1]
                clueString += "\(index + 1). \(clue)\n"
                let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                solutionString += "\(solutionWord.count) letters\n"
                solutions.append(solutionWord)
                let bits = answer.components(separatedBy: "|")
                letterBits += bits
            }
        } else {
            level = 1
            let ac = UIAlertController(title: "Oops!", message: "No more levels to play.  Sorry!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start Over", style: .cancel, handler: levelUp))
            present(ac, animated: true)
        }

        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }

    @objc private func letterTapped(btn: UIButton) {
        if currentAnswer.text == initialGuess {
            currentAnswer.text = ""
        }
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        activatedButtons.append(btn)
        btn.isHidden = true
        UIView.animate(withDuration: 3, delay: 0, options: [], animations: {
            btn.alpha = 0
            btn.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            btn.transform = CGAffineTransform.identity
        }) { (finished: Bool) in
            btn.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var buttonCount = 0
        for subview in view.subviews where subview.tag == buttonTag {
            let btn = subview as! UIButton
            buttonCount += 1
            letterButtons.append(btn)
            // UIButton.addTarget() is like CTRL-dragging from a storyboard to code
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
        loadLevel()
    }
}

