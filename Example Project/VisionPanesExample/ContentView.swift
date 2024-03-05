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
    
    var body: some View {
        VStack {
            Text("Hello, world!")
        }
        .pane(item: item) { item in
            Text("This should show in the pane")
        }
    }
}

// MARK: - Previews
#Preview(windowStyle: .automatic) {
    ContentView()
}
