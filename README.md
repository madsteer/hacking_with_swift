# Hacking with Swift
Place to hold my solutions for the Hacking With Swift training series

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
