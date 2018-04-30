# Hacking with Swift
> Place to hold my solutions for the Hacking With Swift training series

## Table of Contents
* [Table of Contents](#table-of-contents)
  * [Project 1 - Storm Viewer](#project-1---storm-viewer)
  * [Project 2 - Guess the Flag](#project-2---guess-the-flag)
  * [Project 3 - Social Media](#project-3---social-media)
  * [Project 4 - Easy Browser](#project-4---easy-browser)
  * [Project 5 - Word Scramble](#project-5---word-scramble)
  * [Project 6 - Auto Layout](#project-6---auto-layout)
  * [Project 7 - Whitehouse Petitions](#project-7---whitehouse-petitions)
  * [Project 8 - Swifty Words](#project-8---swifty-words)
  * [Project 9 - Grand Central Dispatch](#project-9---grand-central-dispatch)
  * [Project 10 - Names to Faces](#project-10---names-to-faces)
  * [Project 11 - SpriteKit](#project-11---spritekit)
  * [Project 12 - UserDefaults](#project-12---userdefaults)
    + [Using NSCoding](#using-nscoding)
    + [Using Codable](#using-codable)
  * [Project 13 - Instafilter](#project-13---instafilter)
  * [Project 14 - What-a-Penguin](#project-14---what-a-penguin)
  * [Project 15 - Animation](#project-15---animation)
  * [Project 16 - Javascript Injection](#project-16---javascript-injection)
  * [Project 17 - Swifty Ninja](#project-17---swifty-ninja)
  * [Project 18 - Debugging](#project-18---debugging)
  * [Project 19 - Capital Cities](#project-19---capital-cities)
  * [Project 20 - Fireworks Night](#project-20---fireworks-night)
  * [Project 20 - Fireworks Night](#project-20---fireworks-night)
  * [Project 21 - Local Notifications](#project-21---local-notifications)

## Project 1 - Storm Viewer

## Project 2 - Guess the Flag

## Project 3 - Social Media

## Project 4 - Easy Browser

## Project 5 - Word Scramble

## Project 6 - Auto Layout
In this project we fix vertical spacing for project 2 so that it will work in landscape mode, and we learn how to programmatically add constraints to our UI

## Project 7 - Whitehouse Petitions
In this project we learned:
* How to use UITabBarController to reuse one interface design for multiple similar interfaces.
* Create a ViewController class that isn't in the storyboard, but just pushed onto the view in code.

## Project 8 - Swifty Words
In this project we learned:
* programmatically added a method to a button press with .addTarget()
* used `.enumerated()` on an array to get the element and the elements index as a tuple
* Strings:
 * `.index(of:)` - find index of element in array
 * `.joined(separator:)`  - join array of String with "separator"
 * `.replacingOccurencesOf()` - replace all occurrences of X with Y
* `.forEach { $0.function() }` - to execute method on every object in array of objects

## Project 9 - Grand Central Dispatch
In this project we learned about Grand Central Dispatch (GCD).  Specifically:
* `DispatchQueue.main.async { ...}`
* `.performSelector(onMainThread:)`
* `DispatchQueue.global(qos: .userInitiated).async { ... }`
* `.performSelector(inBackground:)`

## Project 10 - Names to Faces
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

## Project 13 - Instafilter
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


## Project 14 - What-a-Penguin
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

## Project 16 - Javascript Injection
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
* `NSDictionary`
* adjust screen for on screen keyboard so you can see whole screen
  * `NotificationCenter`
    * `UIKeyboardWillHide`
    * `UIKeyboardWillChangeFrame`
    * `UIKeyboardFrameEndUserInfoKey`
    * `view.convert`
    * `Notification.Name.UIKeyboardWillHide`
    * `UIEdgeInsets`
    * `UITextView.contentInset`

## Project 17 - Swifty Ninja
* `SKShapeNode`
* `AVAudioPlayer`
* `UIBezierPath`

## Project 18 - Debugging
* All about debugging.
  * `print()`
  * `Assert()`
  * breakpoints
    * conditional logic
    * break on exception
  * some debugging tooling around UIs
    * Show View Frames
    * Capture View Hierarchy

## Project 19 - Capital Cities
* MapKit
* `MKMapView`
* protocols
* annotations
  * `CLLocationCoordinate2D`
  * `MKAnnotation`
  * Customizing annotations
* `MKPinAnnotationView`
  * `canShowCallout()`


## Project 20 - Fireworks Night
* `Timer` object
* More `SKNode`
  * `color`
  * `colorBlendFactor`
* `SKAction.follow()`
* how to detect the device being shaken

## Project 21 - Local Notifications
  * Not the same thing as Push Notifications
  * UNUserNotificationCenter
  * DateComponents
  * UNMutableNotificationContent
  * UNNotificationSound
  * UNNotificationAction
  * UNNotificationCategory
  * UNUserNotificationCenterDelegate
  * UNNotificationDefaultActionIdentifier
  
