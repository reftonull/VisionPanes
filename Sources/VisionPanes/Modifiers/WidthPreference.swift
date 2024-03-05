//
//  File.swift
//  
//
//  Created by Laksh Chakraborty on 3/5/24.
//

import Foundation
import SwiftUI

struct PaneWidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat?
    static var defaultValue: CGFloat? = nil
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = nextValue()
    }
}

extension View {
    public func paneWidth(_ width: CGFloat) -> some View {
        preference(key: PaneWidthPreferenceKey.self, value: width)
    }
}
