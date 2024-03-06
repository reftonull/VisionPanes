# Vision Panes

An easy-to-use SwiftUI package for splitting windows into multiple panes with pleasant animations out of the box. 

## Why

One of the main UX draws of visionOS that sets it apart from anything we've ever seen before is its infinite canvas. Since windowed apps have the ability to be arbitrarily large, panes that would, on other platforms, have eaten into screen real estate can now simply expand the window's size.

Apple does this in the Messages app on visionOS. When the user taps on a contact photo within a chat, the contact details show up in a pane on the trailing edge of the main pane. It is a very good use of space, and is an easy way for developers to make apps feel more at home on visionOS.

Or at least, it would be easy if it weren't difficult to set up. Apple provides no easy way to set panes up. They are, in fact, just subdivisions of a single window, but all the setup is hard to do. Further, there is **no way currently to programmatically change the size of windows in SwiftUI**. To do this, one must drop into UIKit and do all the plumbing from there.

Vision Panes provides a simple SwiftUI interface to this functionality, with pleasant animations to boot.

## Features
- Easy-to-use SwiftUI API that should seem familiar to most SwiftUI creators
- Ability to add multiple panes to each of the four edges of a window
- No need to jump into UIKit
- Pleasant animations

## Requirements
- visionOS 1.0
- Swift 5.10
- Xcode 15.2

## Installation
### Swift Package Manager
Install Vision Panes with SPM:

1. In Xcode, open your project and navigate to File → Add Packages
2. Paste the repository URL ([https://github.com/reftonull/VisionPanes](https://github.com/reftonull/VisionPanes)) and click Next.
3. For Rules, select Up to Next Major Version.
4. Click Add Package.

## Usage
```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.plain) // 1.
    }
}

struct Item: Identifiable, Equatable { // 2.
    var id: String
    var text: String
}

struct ContentView: View {
    @State var item: Item?
    
    var body: some View {
        VStack {
            Button("Show Trailing Pane") {
                item = Item(id: "1", text: "This is in the trailing pane")
            }

            Text("Main pane")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .glassBackgroundEffect()
        .pane(item: item2, placement: .trailing) { item in // 3.
             Text(item.text)
                 .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                 )
                 .glassBackgroundEffect()
         }
    }
}
```

`// 1` The `windowStyle` property on the WindowGroup must be set to `.plain` so that visionOS doesn’t show the glass background behind the whole window

`// 2` Model for our pane, which must be `Identifiable` and `Equatable`

`// 3` The `pane` view modifier looks very much like `sheet`, but doesn’t take in a binding. Pane content goes in the trailing closure. It’s that easy.

## Parameters 
The `pane` view modifier looks like this:
```swift
.pane(
    item: Item?,
    placement: PanePlacement,
    content: (Item) -> Content
)
```
`Item` is your model, which must conform to `Identifiable` and `Equatable`.  The pane is presented when `item` is non-nil, and is dismissed when `item` becomes nil.

`PanePlacement` is an enum which has the following cases:
- `.leading(width: CGFloat, spacing: CGFloat)`
- `.trailin(width: CGFloat, spacing: CGFloat)`
- `.top(width: CGFloat, spacing: CGFloat)`
- `.bottom(width: CGFloat, spacing: CGFloat)`

Sensible defaults are provided.

The `content` closure takes as input the non-nil version of item, allowing you to drive your UI from there.

## Examples
### Panes along all edges

https://github.com/reftonull/VisionPanes/assets/66828631/c270ffc4-79c1-42b3-88ed-7987ceb300f9

<details>
<summary>Source Code</summary>
    
```swift
struct Item: Identifiable, Equatable {
    var id: String
    var text: String
}

struct AllEdges: View {
    @State var item: Item?
    @State var item2: Item?
    @State var item3: Item?
    @State var item4: Item?
    
    var body: some View {
        VStack {
            Button("Show Leading Pane") {
                if item == nil {
                    item = Item(id: "1", text: "Leading Pane")
                } else {
                    item = nil
                }
            }
            
            Button("Show Trailing Pane") {
                if item2 == nil {
                    item2 = Item(id: "1", text: "Leading Pane")
                } else {
                    item2 = nil
                }
            }
            
            Button("Show Top Pane") {
                if item3 == nil {
                    item3 = Item(id: "1", text: "Leading Pane")
                } else {
                    item3 = nil
                }
            }
            
            Button("Show Bottom Pane") {
                if item4 == nil {
                    item4 = Item(id: "1", text: "Leading Pane")
                } else {
                    item4 = nil
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .glassBackgroundEffect()
        .pane(item: item, placement: .leading) { item in
            Text(item.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassBackgroundEffect()
        }
        .pane(item: item2, placement: .trailing) { item in
            Text(item.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassBackgroundEffect()
        }
        .pane(item: item3, placement: .top) { item in
            Text(item.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassBackgroundEffect()
        }
        .pane(item: item4, placement: .bottom) { item in
            Text(item.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassBackgroundEffect()
        }
    }
}
```

</details>

### Multiple panes along the same edge

https://github.com/reftonull/VisionPanes/assets/66828631/51bbe736-2929-4b06-a0eb-77fea6cf32e1

<details>
<summary>Source Code</summary>
    
```swift
struct Item: Identifiable, Equatable {
    var id: String
    var text: String
}

struct SameEdge: View {
    @State var item: Item?
    @State var item2: Item?
    
    var body: some View {
        VStack {
            Button("Show Pane 1") {
                if item == nil {
                    item = Item(id: "1", text: "Pane 1")
                } else {
                    item = nil
                }
            }
            
            Button("Show Pane 2") {
                if item2 == nil {
                    item2 = Item(id: "1", text: "Pane 2")
                } else {
                    item2 = nil
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .glassBackgroundEffect()
        .pane(item: item, placement: .trailing) { item in
            Text(item.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassBackgroundEffect()
        }
        .pane(item: item2, placement: .trailing) { item in
            Text(item.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassBackgroundEffect()
        }
    }
}
```

</details>

## Demo Project
The demo project can be found here. It includes both examples above, and will expand with more use cases in the future.

## Credits
This package is built by [Laksh Chakraborty](https://github.com/reftonull).

A huge shoutout to [Steve Troughton-Smith](https://github.com/steventroughtonsmith) for his original example code that inspired this package. See his project [here](https://github.com/steventroughtonsmith/VisionMessagesDualPane).

## License
This package is available under an MIT License. See the license file [here](https://github.com/reftonull/VisionPanes/blob/main/LICENSE).

