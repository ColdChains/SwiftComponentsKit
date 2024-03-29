//
//  ViewController.swift
//  SwiftComponentsKitDemo
//
//  Created by lax on 2022/9/28.
//

import UIKit
import SwiftComponentsKit

class TipsTestViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar = true
        navigationBar?.titleLabel?.text = "TipsView"
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        testLoadView()
        testToastView()
        testHUDView()

    }

    func testHUDView() {

        HUDView.show(in: self.view)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8) {
            HUDView.hide()
        }

//        view.showHUD()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8) {
//            self.view.hideHUD()
//        }

    }

    func testToastView() {

        ToastViewConfig.shared.position = .bottom

//        if #available(iOS 13.0, *) {
//            ToastView.showError("adfadf", image: UIImage(systemName: "square.and.arrow.up"))
//        }
        Toast("hahahaha")
        return;

    }

    func testLoadView() {

        LoadViewConfig.shared.errorMessage = "hahaha"

        view.loading("loading")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            self.view.endLoading()
            if #available(iOS 13.0, *) {
//                self.view.endLoadingWithError(image: UIImage(systemName: "square.and.arrow.up")) {
//                    self.startRequest()
//                }
                self.view.endLoadingWithNoData(image: UIImage(systemName: "square.and.arrow.up"))
            }
        }
    }
    
}

