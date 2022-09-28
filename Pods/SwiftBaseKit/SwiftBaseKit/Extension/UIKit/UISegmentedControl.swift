//
//  UISegmentedControl.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public extension UISegmentedControl {
    
    func configiOS13Style() {
        if #available(iOS 13, *) {
            let tintColorImage = UIImage.image(color: tintColor)
            setBackgroundImage(UIImage.image(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
            setBackgroundImage(UIImage.image(color: tintColor.withAlphaComponent(0.2)), for: .highlighted, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: [.highlighted, .selected], barMetrics: .default)
            setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            setTitleTextAttributes([.foregroundColor: UIColor.darkText.cgColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], for: .normal)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
}
