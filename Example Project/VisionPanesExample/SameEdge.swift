//
//  SameEdge.swift
//  VisionPanesExample
//
//  Created by Laksh Chakraborty on 3/6/24.
//

import SwiftUI
import VisionPanes

// MARK: - Example view for panes along same edge
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

// MARK: - Previews
#Preview {
    SameEdge()
}
