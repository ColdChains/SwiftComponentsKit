//
//  PageControl.swift
//  RecycleView
//
//  Created by lax on 2022/9/13.
//

import UIKit

public protocol RecyclePageControlDelegate: NSObjectProtocol {

    /// 点击指示器
    func recyclePageControl(_ pageControl: UIView, didSelectAt page: Int)

}

public extension RecyclePageControlDelegate {

    func recyclePageControl(_ pageControl: UIView, didSelectAt page: Int) {}

}

open class RecyclePageControl: UIPageControl {
    
    weak open var delegate: RecyclePageControlDelegate?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(pageControlValueChanged), for: .touchUpInside)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func pageControlValueChanged() {
        delegate?.recyclePageControl(self, didSelectAt: currentPage)
    }

}

extension RecyclePageControl: RecyclePageControlProtocol {
    
    public func recyclePageControlSetNumberOfPages(_ numberOfPages: Int) {
        self.numberOfPages = numberOfPages
    }
    
    public func recyclePageControlSetCurrentPage(_ currentPage: Int) {
        self.currentPage = currentPage
    }
    
}
