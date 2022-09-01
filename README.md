
# Technical Test
(Xcode 13.4.1)

This iOS project follows the MVC pattern and adds a layer of app coordinator (see *Coordinator* below).
The app display a list of products and allow the user to see the details on tap. He can also add a product to the cart and see the summary of his order.

# Project Architecture

## MVC Design Pattern

> MVC is a software development pattern made up of three main objects:
>
> As shown above, the MVVM pattern consists of three layers:
>
>  - The _Model_ is where your data resides. Things like persistence, model objects, parsers, managers, and networking code live there.
>  - The _View_ layer is the face of your app. Its classes are often reusable as they don’t contain any domain-specific logic. For example, a `UILabel` is a view that presents text on the screen, and it’s reusable and extensible.
>  - The _Controller_ mediates between the view and the model via the delegation pattern. In an ideal scenario, the controller entity won’t know the concrete view it’s dealing with. Instead, it will communicate with an abstraction via a protocol. A classic example is the way a `UITableView` communicates with its data source via the `UITableViewDataSource` protocol.
>
> *(Felipe Laso-Marsetti on [raywenderlich.com](https://www.raywenderlich.com/1000705-model-view-controller-mvc-in-ios-a-modern-approach))*

## Coordinator

Since MVC design pattern did a great job with splitting logic of the controller from the UI. I tried to add the notion of coordinator that allows us to remove the job of app navigation from our view controllers, helping make them more manageable and more reusable, while also letting us adjust our app's flow whenever we need.

# Specifications

- This project is written in Swift
- No .xib or .storyboard has been used
- It has no external library
- Is universal with iPhone / iPad
- Compatible iOS 15+

# Few references

- https://cocoacasts.com/model-view-viewmodel-in-swift
- https://developer.apple.com/documentation/swift
