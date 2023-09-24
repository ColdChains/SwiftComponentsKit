//
//  ProgressView.swift
//  SwiftViewController
//
//  Created by lax on 2022/9/7.
//

import UIKit
import SnapKit
import SwiftBaseKit

open class ProgressView: UIView {

    open var progress: CGFloat = 0 {
        didSet {
            let width = self.bounds.size.width * progress;
            foreView.snp.updateConstraints { make in
                make.width.equalTo(width)
            }
        }
    }
    
    private lazy var foreView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseViewControllerConfig.shared.progressColor
        return view;
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: CGRect())
        addSubview(foreView)
        foreView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(0)
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open func setProgress(progress: CGFloat, animated: Bool, completion:((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.progress = progress
            self.layoutIfNeeded()
        } completion: { finished in
            if let _ = completion {
                completion?(finished)
            }
        }
    }

}
