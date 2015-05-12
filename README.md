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

<!--## Installation-->

<!--Swiftstraints is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:-->

<!--```ruby-->
<!--pod 'Swiftstraints'-->
<!--```-->

<!--Alternatively, you can clone this repo or download it as a zip and include the classes in your project.-->
