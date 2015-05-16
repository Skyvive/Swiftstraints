# Swiftstraints

Swiftstraints can turn verbose auto-layout code:
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
let constraint = blueView.width == redView.width
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
let constraints = H|[leftView]-10-[rightView]|
```
That was easy!

## Installation

Swiftstraints is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:
```ruby
pod 'Swiftstraints'
```
Alternatively, you can clone this repo or download it as a zip and include the classes in your project.

## Constraints

With Swiftstraints you can create constraints that look just Apple's generic constraint definition:
```swift
item1.attribute1 = multiplier × item2.attribute2 + constant
```
Swifstraints extends UIView to offer layout attributes as properties:
```swift
let view = UIView()
view.width
view.height
view.trailing
view.centerX
etc...
```
Swiftstraints also extends a few common operators so that you can easily create custom constraints:
```swift
let blueView = UIView()
let redView = UIView()
let constraint = blueView.height == redView.height
```
Just as you would expect, you can specify a multiplier:
```swift
let constraint = blueView.height == 2.0 * redView.height
```
Or add a constant:
```swift
let constraint = blueView.height == redView.height + 10.0
```
You can specify inequalities:
```swift
let constraint = blueView.height <= redView.height
```
And you can define constant constraints if you so choose:
```swift
let constraint = blueView.height == 100.0
```
You can also set a custom priority level for your constraint with the '^' marker:
```swift
let constraint = blueView.height == 1.2 * redView.height + 12.0 ^ 300
```
Swiftstraints can readily compute relatively complex constraints:
```swift
let constraint = blueView.height * 1.4 - 5.0 >= redView.height / 3.0 + 400 ^ 800
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
With Swiftstraints you can specify the same constraints in one line of code:
```swift
let constraints = H|[leftView]-10-[rightView]|
```
Swiftstraints adheres closely to the Visual Format Language, with a few exceptions:
```swift
// Specifying the orientation is always required, even for horizontal layouts. 
// The colons ':' are ommitted.
let horizontalConstraints = H[leftView]-[rightView] // "H:[leftView]-[rightView]"
let verticalConstraints = V[topView]-[bottomView] // "V:[leftView]-[rightView]"

// Anywhere you would normally use parentheses, use brackets instead.
let constraints = H[leftView[>=80,<=100]]-[rightView] // "H:[leftView(>=80,<=100)]-[rightView]"

// Use '^' instead of '@' to specify priority.
let constraints = H|-<=20^300-[leftView]-| // "H:|-<=20@300-[leftView]-|"

// Lastly, to have two views sit adjacent to each other use the '~' marker.
let constraints = H[leftView]~[rightView] // H:[leftView][rightView]
```
With Swiftstraints adding multiple constraints simultaneously to a view is a breeze:
```swift
superview.addConstraints(topView.top == superview.bottom, V|topView|-|bottomView|)
```

## Author

Brad Hilton, brad@skyvive.com

## License

Swiftstraints is available under the MIT license. See the LICENSE file for more info.
