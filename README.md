# Swiftstraints

`Swiftstraints` can turn verbose auto-layout code:
```swift
let constraint = NSLayoutConstraint(item: blueView,
                               attribute: NSLayoutAttribute.Width,
                               relatedBy: NSLayoutRelation.Equal,
                                  toItem: redView,
                               attribute: NSLayoutAttribute.Width,
                              multiplier: 1.0,
                                constant: 0.0)
```
Into one just one line of code:
```swift
let constraint = blueView.widthAnchor == redView.widthAnchor
```
Or transform your less than consise visual format language code:
```swift
let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[leftView]-10-[rightView]|",
                               options: NSLayoutFormatOptions(0),
                               metrics: nil,
                               views: ["leftView":leftView, "rightView":rightView])
```
Into the following:
``` swift
let constraints = NSLayoutConstraints("H:|[\(leftView)]-10-[\(rightView)]|")
```
That was easy!

## Installation

`Swiftstraints` is available through [CocoaPods](http://cocoapods.org). To install, simply include the following lines in your podfile:
```ruby
use_frameworks!
pod 'Swiftstraints'
```
Be sure to import the module at the top of your .swift files:
```swift
import Swiftstraints
```
Alternatively, clone this repo or download it as a zip and include the classes in your project.

## Constraints

With `Swiftstraints` you can create constraints that look just Apple's generic constraint definition:
```swift
item1.attribute1 = multiplier × item2.attribute2 + constant
```
`Swifstraints` utilizes the new layout anchors introduced in iOS 9:
```swift
let view = UIView()
view.widthAnchor
view.heightAnchor
view.trailingAnchor
view.centerXAnchor
etc...
```
`Swiftstraints` implements operator overloading so that you can easily create custom constraints:
```swift
let blueView = UIView()
let redView = UIView()
let constraint = blueView.heightAnchor == redView.heightAnchor
```
Just as you would expect, you can specify a multiplier:
```swift
let constraint = blueView.heightAnchor == 2.0 * redView.heightAnchor
```
Or add a constant:
```swift
let constraint = blueView.heightAnchor == redView.heightAnchor + 10.0
```
You can specify inequalities:
```swift
let constraint = blueView.heightAnchor <= redView.heightAnchor
```
And you can define constant constraints if you so choose:
```swift
let constraint = blueView.heightAnchor == 100.0
```
Swiftstraints can readily compute relatively complex constraints:
```swift
let constraint = blueView.heightAnchor * 1.4 - 5.0 >= redView.heightAnchor / 3.0 + 400
```
It's really easy.

## Visual Format Language

Apple provides an API that lets you create multiple constraints simultaneously with the Visual Format Language. As we saw before it can be a little cumbersome:
```swift
let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[leftView]-10-[rightView]|",
                               options: NSLayoutFormatOptions(0),
                               metrics: nil,
                               views: ["leftView":leftView, "rightView":rightView])
```
`Swiftstraints` uses string interpolation to let you specify the same constraints in one line of code:
```swift
let constraints = NSLayoutConstraints("H:|[\(leftView)]-10-[\(rightView)]|")
```
`Swiftstraints` also extends `UIView` so that you can add constraints easily using the interpolated string format:
```swift
superview.addConstraints("H:|[\(leftView)]-10-[\(rightView)]|")
```
Super easy, super simple.
## Revision History

* 3.0.1 - Bug fixes and limited iOS 8 support (Thank you catjia1011)
* 3.0.0 - Updated to Swift 3
* 2.2.0 - Added support for UILayoutPriority
* 2.1.0 - Fixed a view reference bug and added a new convenience method for adding constraints
* 2.0.2 - Added support for tvOS target.
* 2.0.1 - Updated to include support for axis anchors, increased test coverage and more documentation.
* 2.0.0 - Updated for Swift 2.0 and iOS 9. Now uses layout anchors for simple constraints and string interpolation for Visual Format Language constraints.
* 1.1.0 - Minor API tweaks
* 1.0.0 - Initial Release

## Author

Brad Hilton, brad@skyvive.com

## License

Swiftstraints is available under the MIT license. See the LICENSE file for more info.
