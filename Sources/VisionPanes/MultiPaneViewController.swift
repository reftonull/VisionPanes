//
//  File.swift
//  
//
//  Created by Laksh Chakraborty on 3/5/24.
//

import Foundation
import UIKit
import SwiftUI

class MultiPaneViewController<Item, MainView, PaneView>: UIViewController where Item: Identifiable, MainView: View, PaneView: View {
    var item: Item?
    var previousItem: Item?
    
    var configuration: MultiPaneViewConfiguration
    
    var mainController: UIHostingController<MainView>? = nil
    var paneController: UIHostingController<PaneView>? = nil
    
    init(item: Item?, configuration: MultiPaneViewConfiguration, mainView: MainView, paneView: PaneView) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
        
        mainController = UIHostingController(rootView: mainView)
        
        paneController = UIHostingController(rootView: paneView)
        
        addChild(mainController!)
        view.addSubview(mainController!.view)
        
        addChild(paneController!)
        view.addSubview(paneController!.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Window Geometry
    
    func _updateWindowGeometry() {
        guard let window = view.window else { return }
        guard let scene = window.windowScene else { return }
        
        let geo = UIWindowScene.GeometryPreferences.Vision()
        
        geo.size = window.bounds.size
        
        switch configuration.placement {
        case let .trailing(width: width, spacing: spacing):
            if item != nil {
                geo.size?.width += width + spacing
            } else {
                geo.size?.width -= width + spacing
            }
            
        case let .leading(width: width, spacing: spacing):
            if item != nil {
                geo.size?.width += width + spacing
            } else {
                geo.size?.width -= width + spacing
            }
            
        case .top(height: let height, spacing: let spacing):
            if item != nil {
                geo.size?.height += height + spacing
            } else {
                geo.size?.height -= height + spacing
            }
            
        case .bottom(height: let height, spacing: let spacing):
            if item != nil {
                geo.size?.height += height + spacing
            } else {
                geo.size?.height -= height + spacing
            }
        }
        
        scene.requestGeometryUpdate(geo)
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        switch configuration.placement {
        case let .leading(width: width, spacing: spacing):
            let division = view.bounds.divided(atDistance: width + spacing, from: .minXEdge)
            
            mainController?.view.frame = item != nil ? division.remainder : view.bounds
            paneController?.view.frame = division.slice.divided(atDistance: spacing, from: .maxXEdge).remainder
        
        case let .trailing(width: width, spacing: spacing):
            let division = view.bounds.divided(atDistance: width + spacing, from: .maxXEdge)
            
            mainController?.view.frame = item != nil ? division.remainder : view.bounds
            paneController?.view.frame = division.slice.divided(atDistance: spacing, from: .minXEdge).remainder
            
        case let .top(height: height, spacing: spacing):
            let division = view.bounds.divided(atDistance: height + spacing, from: .minYEdge)
            
            mainController?.view.frame = item != nil ? division.remainder : view.bounds
            paneController?.view.frame = division.slice.divided(atDistance: spacing, from: .maxYEdge).remainder

        case let .bottom(height: height, spacing: spacing):
            let division = view.bounds.divided(atDistance: height + spacing, from: .maxYEdge)
            
            mainController?.view.frame = item != nil ? division.remainder : view.bounds
            paneController?.view.frame = division.slice.divided(atDistance: spacing, from: .minYEdge).remainder
        }
    }
    
    override var preferredContainerBackgroundStyle: UIContainerBackgroundStyle {
        return .hidden
    }
}
