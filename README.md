# Hacking with Swift
> Place to hold my solutions for the Hacking With Swift training series

## Table of Contents
* [Project 6](#project-6)
* [Project 7](#project-7)
* [Project 8](#project-8)
* [Project 9](#project-9)
* [Project 10](#project-10)
* [Project 11 - SpriteKit](#project-11---spritekit)
* [Project 12 - UserDefaults](#project-12---userdefaults)
    + [Using NSCoding](#using-nscoding)
    + [Using Codable](#using-codable)
* [Project 13](#project-13)
* [Project 14](#project-14)
* [Project 15 - Animation](#project-15---animation)

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
* Good for mingling Swift with Objective-C
* `UserDefaults`
* `NSKeyedArchiver`

### Using Codable
* Better if pure Swift
* `Codable` interface
* `JSONEncoder`
* `JSONDecoder`

## Project 13
* `UISlider`
* `kCIInputImageKey`
* `kCIInputRadiusKey`
* `kCIInputScaleKey`
* `kCIInputCenterKey`
* `kCIInputIntensityKey`
* `CIImage`
* `CGImage`
* `CIFilter`
* `CIBumpDistortion`
* `UIImageWriteToSavedPhotosAlbum`
* Info.plist - `Privacy - Photo Library Usage Description`
* Info.plist - `Privacy - Photo Library Additions Usage Description`


## Project 14
* `SKCropNode`
* `SKTexture`
* `SKAction`
* GDD's `asyncAfter()`
* `*.caf` sound files
  * check target membership in file inspector if it appears the file is inaccessible
* scale SKSpriteNode

## Project 15 - Animation
* `UIView.animate()` - takes two closures
  * default animatons versus "spring" animations
* `CGAffineTransform`
  * `CGAffineTransform(scaleX: 2, y: 2)` to double the size
  * `CGAffineTransform.identity` to reset to original
  * `CGAffineTransform(translationX: -256, y: -256)` to move the object up and to the left (negative number)
  * `CGAffineTransform(rotationAngle:CGFloat.pi)` - rotation angle in radians - 2*pi is 360 degrees in radians
* `imageView.alpha` - 0 to 1.  0 fully transparent, 1 fully opaque

## Project 16
* Safari Extension
* `ActionViewController`
* `NSExtensionContext`
* `NSItemProvider`
* `loadItem(forTypeIdentifier: )`
* In the Extension's `info.plist`: `NSExtension`
  * `NSExtensionAttributes`
    * `NSExtensionActivationRule`
      * `NSExtensionActivationSupportsWebPageWithMaxCount`
    * `NSExtensionJavaScriptPreprocessingFile`


