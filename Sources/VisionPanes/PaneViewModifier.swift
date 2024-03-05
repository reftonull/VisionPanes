import SwiftUI

private struct PaneViewModifier<Item, PaneContent>: ViewModifier where Item: Identifiable & Equatable, PaneContent: View {
    var item: Item?
    @State var lastItem: Item? = nil
    @ViewBuilder var paneContent: (Item) -> PaneContent
    
    func body(content: Content) -> some View {
        MultiPaneView(item: item) {
            content
        } paneView: {
            VStack {
                VStack {
                    if let lastItem {
                        paneContent(item ?? lastItem)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(item != nil ? 1 : 0)
                .offset(z: item != nil ? 0 : -64)
            }
            .animation(.default, value: item)
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
        @ViewBuilder paneContent: @escaping (Item) -> PaneContent
    ) -> some View where Item: Identifiable & Equatable, PaneContent: View {
        modifier(PaneViewModifier(item: item, paneContent: paneContent))
    }
}
