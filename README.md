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

## Author

Brad Hilton, brad.hilton.nw@gmail.com

## License

Swiftstraints is available under the MIT license. See the LICENSE file for more info.
