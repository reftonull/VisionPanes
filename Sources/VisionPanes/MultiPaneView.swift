//
//  SwiftUIView.swift
//  
//
//  Created by Laksh Chakraborty on 3/5/24.
//

import SwiftUI

struct MultiPaneView<Item, MainView, PaneView>: UIViewControllerRepresentable where Item: Identifiable, MainView: View, PaneView: View {
    var item: Item?
    var configuration: MultiPaneViewConfiguration
    
    @ViewBuilder var mainView: () -> MainView
    @ViewBuilder var paneView: () -> PaneView
    
    func makeUIViewController(context: Context) -> MultiPaneViewController<Item, MainView, PaneView> {
        let viewController = MultiPaneViewController(
            item: item,
            configuration: configuration,
            mainView: mainView(),
            paneView: paneView()
        )
        return viewController
    }
    
    func updateUIViewController(
        _ uiViewController: MultiPaneViewController<Item, MainView, PaneView>,
        context: Context
    ) {
        uiViewController.item = item
        uiViewController.configuration = configuration
        
        uiViewController._updateWindowGeometry()
        
        uiViewController.paneController?.rootView = paneView()
    }
}
