//
//  ViewController.swift
//  Project05
//
//  Created by Cory Steers on 3/1/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                            action: #selector(promptForAnswer))

        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt"),
            let startWords = try? String(contentsOfFile: startWordsPath) {
            allWords = startWords.components(separatedBy: "\n")
        } else {
            allWords = [ "silkworm" ]
        }
        startGame()
    }

    func startGame() {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] _ in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        let errorTitle: String
        let errorMessage: String
        if isPossible(lowerAnswer) {
            if isOriginal(lowerAnswer) {
                if isReal(lowerAnswer) {
                    usedWords.insert(answer, at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)

                    return // exit before we set up the alert controller
                } else {
                    errorTitle = "Word '\(lowerAnswer)' not recognized"
                    errorMessage = "You can't just make up words, you know!"
                }
            } else {
                errorTitle = "Word '\(lowerAnswer)' used already"
                errorMessage = "No duplicate words!"
            }
        } else {
            errorTitle = "Word '\(lowerAnswer)' not possible"
            errorMessage = "You can't spell that word from '\(title!.lowercased())'!"
        }

        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func isPossible(_ word: String) -> Bool {
        var tempWord = title!.lowercased()
        for letter in word {
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        return true
    }

    func isOriginal(_ word: String) -> Bool {
        return !usedWords.contains(word)
    }

    func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        if range.length < 1 {
            return false // we don't allow blank words
        }
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range,
                                                            startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
}

