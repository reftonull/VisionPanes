import SwiftUI

private struct PaneViewModifier<Item, PaneContent>: ViewModifier where Item: Identifiable & Equatable, PaneContent: View {
    var item: Item?
    @State var lastItem: Item? = nil
    
    var placement: PanePlacement
    
    @ViewBuilder var paneContent: (Item) -> PaneContent
    
    var opacity: CGFloat {
        item == nil ? 0 : 1
    }
    
    var offset: CGFloat {
        item == nil ? -64 : 0
    }

    func body(content: Content) -> some View {
        MultiPaneView(item: item, configuration: MultiPaneViewConfiguration(placement: placement)) {
            content
        } paneView: {
            VStack {
                VStack {
                    if let lastItem {
                        paneContent(item ?? lastItem)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(opacity)
                .offset(z: offset)
            }
            .animation(.spring(duration: 0.3), value: item)
            .onChange(of: item) { oldValue, newValue in
                if let newValue {
                    self.lastItem = newValue
                }
            }
        }

    }
}

extension View {
    public func pane<Item, PaneContent>(
        item: Item?,
        placement: PanePlacement = .trailing,
        @ViewBuilder paneContent: @escaping (Item) -> PaneContent
    ) -> some View where Item: Identifiable & Equatable, PaneContent: View {
        modifier(
            PaneViewModifier(
                item: item,
                placement: placement,
                paneContent: paneContent
            )
        )
    }
}
