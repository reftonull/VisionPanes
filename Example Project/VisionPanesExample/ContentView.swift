//
//  ContentView.swift
//  Example Project
//
//  Created by Laksh Chakraborty on 3/5/24.
//

import SwiftUI
import VisionPanes

// MARK: - Example item struct, must be Identifiable and Equatable
struct Item: Identifiable, Equatable {
    var id: String
    var text: String
}

// MARK: - Example Simple View
struct ContentView: View {
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

// MARK: - Previews
#Preview(windowStyle: .automatic) {
    ContentView()
}
