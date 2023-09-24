//
//  RecycleTestViewController.swift
//  SwiftComponentsKitDemo
//
//  Created by lax on 2022/9/21.
//

import UIKit
import SwiftBaseKit
import SwiftComponentsKit

class RecycleTestViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationBar = true
        navigationBar?.titleLabel?.text = "PresentMenuBarController"
        
        // 卡片效果
        let cardView = RecycleView()
        cardView.delegate = self
        cardView.dataSource = self
        cardView.edgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        cardView.minSpacing = 12
        cardView.canLoop = false
        cardView.tag = 100
        
        view.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(NavigationBarHeight + 10)
            make.height.equalTo(100)
        }
        
        // 轮播图效果
        let bannerView = RecycleView()
        bannerView.delegate = self
        bannerView.dataSource = self
        bannerView.edgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        bannerView.minSpacing = 12
        bannerView.canLoop = true
        bannerView.autoScroll = true
        
        let control = RecyclePageControl()
        control.backgroundColor = .lightGray
        control.pageIndicatorTintColor = .red
        control.currentPageIndicatorTintColor = .white
        control.delegate = cardView
        bannerView.pageControl = control
        
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(cardView.snp.bottom).offset(44)
            make.height.equalTo(333)
        }
        
    }

}

extension RecycleTestViewController: RecycleViewDelegateFlowlayout, RecycleViewDataSource {
    
    func numberOfItemsInRecycleView(_ recycleView: RecycleView) -> Int {
        return recycleView.tag == 100 ? 10 : 3
    }
    
    func sizeForItemInRecycleView(_ recycleView: RecycleView) -> CGSize {
        return recycleView.tag == 100 ? CGSize(width: 100, height: 100) : CGSize(width: UIScreen.main.bounds.size.width - 18 * 2, height: 333)
    }
    
    func recycleView(_ recycleView: RecycleView, cellForItemAt index: Int) -> UIView? {
        var cell = recycleView.dequeueReusableCell() as? UIImageView
        if cell == nil {
            cell = UIImageView()
        }
        cell?.backgroundColor = [UIColor.green, UIColor.orange, UIColor.red][index % 3]
        return cell
    }
    
    func recycleView(_ recycleView: RecycleView, didSelectRowAt index: Int) {
        print(index)
    }
    
}

