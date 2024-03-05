//
//  SwiftUIView.swift
//  
//
//  Created by Laksh Chakraborty on 3/5/24.
//

import SwiftUI

struct MultiPaneView<Item, MainView, PaneView>: UIViewControllerRepresentable where Item: Identifiable, MainView: View, PaneView: View {
    var item: Item?
    @State var oldItem: Item? = nil
    
    @ViewBuilder var mainView: () -> MainView
    @ViewBuilder var paneView: () -> PaneView
    
    func makeUIViewController(context: Context) -> MultiPaneViewController<Item, MainView, PaneView> {
        let viewController = MultiPaneViewController(
            item: item,
            mainView: mainView(),
            paneView: paneView()
        )
        return viewController
    }
    
    func updateUIViewController(
        _ uiViewController: MultiPaneViewController<Item, MainView, PaneView>,
        context: Context
    ) {
        if (oldItem == nil && item != nil) || (oldItem != nil && item == nil) {
            uiViewController._updateWindowGeometry()
            oldItem = item
        }
        
        uiViewController.paneController?.rootView = paneView()
    }
}
