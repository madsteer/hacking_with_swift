//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .white
//
//        let label = UILabel()
//        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
//        label.text = "Hello World!"
//        label.textColor = .black
//
//        view.addSubview(label)
//        self.view = view
//    }
//}
// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()


guard let url = URL(string: "http://norvig.com/ngrams/TWL06.txt") else { exit(1) }
guard let string = try? String(contentsOf: url) else { exit(2) }

let words = string.components(separatedBy: .newlines)

let wordMap = Dictionary(grouping: words, by: { item in item.count })

let allLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

func findPath(between sourceWord: String, and targetWord: String) -> [String]? {
    guard sourceWord != targetWord else { return nil }
    guard sourceWord.count == targetWord.count else { return nil }

    let lexicon = Set(wordMap[startWord.count] ?? [String]())

    var seen: Set = [sourceWord]

    var queue: [(item: String, path: [String])] = [(sourceWord, [])]

    while true {
        if queue.count == 0 { return nil }
        let (item, path) = queue.removeFirst()
        if item == targetWord { return path + [item] }
        let itemAsArray = Array(item)
        for characterIndex in itemAsArray.indices {
            for letter in allLetters {
                var copyAsArray = itemAsArray
                copyAsArray[characterIndex] = letter
                let oneLetterAway = String(copyAsArray)

                if lexicon.contains(oneLetterAway) && !seen.contains(oneLetterAway) {
                    queue.append((oneLetterAway, path + [item]))
                    seen.insert(oneLetterAway)
                }
            }
        }
    }
}


let startWord = "TOON"
let endWord = "PLEA"
var startDate = Date()
var result = findPath(between: startWord, and: endWord)
var finishDate = Date()
print("\(startWord) -> \(endWord): \(result ?? ["nothing"]), in \(finishDate.timeIntervalSince(startDate)) seconds")


