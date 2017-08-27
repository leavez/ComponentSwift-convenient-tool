//
//  PlaceholderComponent.swift
//  Pods
//
//  Created by Gao on 8/27/17.
//
//

import Foundation
import ComponentSwift

public class PlaceholderComponent: Component {

    public init(size:CGSize) {
        super.init(view: nil, size: LayoutSize(cgSize: size))
    }
    public init(width: CGFloat) {
        super.init(view: nil, size: LayoutSize(width:.p(width)))
    }
    public init(height: CGFloat) {
        super.init(view: nil, size: LayoutSize(height: .p(height)))
    }
}
