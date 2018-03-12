# Hacking with Swift
> Place to hold my solutions for the Hacking With Swift training series

## Table of Contents
* [Project 6](#project-6)
* [Project 7](#project-7)
* [Project 8](#project-8)
* [Project 9](#project-9)
* [Project 10](#project-10)
* [Project 11 - SpriteKit](#project-11---spritekit)

## Project 6
In this project we fix vertical spacing for project 2 so that it will work in landscape mode, and we learn how to programmatically add constraints to our UI

## Project 7
In this project we learned:
* How to use UITabBarController to reuse one interface design for multiple similar interfaces.
* Create a ViewController class that isn't in the storyboard, but just pushed onto the view in code.

## Project 8
In this project we learned:
* programmatically added a method to a button press with .addTarget()
* used `.enumerated()` on an array to get the element and the elements index as a tuple
* Strings:
 * `.index(of:)` - find index of element in array
 * `.joined(separator:)`  - join array of String with "separator"
 * `.replacingOccurencesOf()` - replace all occurrences of X with Y
* `.forEach { $0.function() }` - to execute method on every object in array of objects

## Project 9
In this project we learned about Grand Central Dispatch (GCD).  Specifically:
* `DispatchQueue.main.async { ...}`
* `.performSelector(onMainThread:)`
* `DispatchQueue.global(qos: .userInitiated).async { ... }`
* `.performSelector(inBackground:)`

## Project 10
Here we learned:
* `UIImagePcikerController` to pick an image from the camera roll
* custom class (Person)
* `cellForItemAt`, `numberOfItemsInSection`, `didSelectItemAt` for `UICollectionViewController` is very similar to the "ForRowAt" methods in `UITableViewController`
* `UIIImage(ContentsOfFile:)` to read in data as an image (like reading a file in as `[String]`)
* `UIImageJPEGRepresentation()` to convert a UIImage object to a Data object
* `Data.write(to:)` to write data to a file in `~/Documents/`

## Project 11 - SpriteKit
Here we learned about SpriteKit.  Specifically:
* SpriteKit
* `SKSpriteNode`
* `SKAction`
* `SKLabelNode`
* `SKEmitterNode`

## Project 12 - UserDefaults
### Using NSCoding
* `UserDefaults`
* `NSKeyedArchiver`

### Using Codable
