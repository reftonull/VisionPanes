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
    var mainController: UIHostingController<MainView>? = nil
    var paneController: UIHostingController<PaneView>? = nil
    
    init(item: Item?, mainView: MainView, paneView: PaneView) {
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
        
        scene.requestGeometryUpdate(geo)
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        mainController?.view.frame = view.bounds
    }
    
    override var preferredContainerBackgroundStyle: UIContainerBackgroundStyle {
        return .hidden
    }
}
