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


//enum EnemyType {
//    case number(Int)
//    indirect case random(EnemyType.number(Int))
//}

enum ForceBomb: Int {
    case always = 0, never, random

    static func randomize() -> ForceBomb {
        let randomInt = Int(arc4random_uniform(UInt32((6 - 0) + 1))) + 0
        return randomInt == 0 ? .always : .never
    }
}

var enemy = ForceBomb.always

print("\(ForceBomb.always) is \(ForceBomb.always.rawValue)")
print("\(ForceBomb.never) is \(ForceBomb.never.rawValue)")

if case .never = enemy {
    // do
}
var enemyType = Int(arc4random_uniform(UInt32((6 - 0) + 1))) + 0

//let forceBomb = ForceBomb.random




