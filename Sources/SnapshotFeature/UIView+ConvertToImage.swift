//
//  UIView+ConvertToImage.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/18.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
