//
//  NetworkImageComponent+Downloader.swift
//  ComponentSwift_ConvenientTool
//
//  Created by Gao on 25/08/2017.
//

import ComponentSwift

extension NetworkImageComponnet {

    public convenience init(url: URL?,
                            size: LayoutSize? = nil,
                            placeholderImage: UIImage? = nil,
                            attributes: ViewAttributeMap? = nil) {
        self.init(__url: url, imageDownloader: CSImageDownloader.shared(), scenePath: nil, size: size, placeholderImage: placeholderImage, cropRect: .zero, attributes: attributes)
    }
}

