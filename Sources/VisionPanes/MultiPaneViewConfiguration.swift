//
//  File.swift
//  
//
//  Created by Laksh Chakraborty on 3/5/24.
//

import Foundation

struct MultiPaneViewConfiguration {
    var placement: PanePlacement
}

public enum PanePlacement {
    case leading(width: CGFloat = 300, spacing: CGFloat = 16)
    case trailing(width: CGFloat = 300, spacing: CGFloat = 16)
    case top(height: CGFloat = 200, spacing: CGFloat = 16)
    case bottom(height: CGFloat = 200, spacing: CGFloat = 16)

    public static var leading: Self {
        return .leading()
    }
    
    public static var trailing: Self {
        return .trailing()
    }
    
    public static var top: Self {
        return .top()
    }
    
    public static var bottom: Self {
        return .bottom()
    }
}

