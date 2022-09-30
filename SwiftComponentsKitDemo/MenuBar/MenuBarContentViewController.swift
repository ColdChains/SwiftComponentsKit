//
//  MenuBarContentViewController.swift
//  SwiftComponentsKitDemo
//
//  Created by lax on 2022/9/20.
//

import UIKit
import SwiftComponentsKit

class MenuBarContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension MenuBarContentViewController: MenuBarProtocol {
    
    func menuBarScrollView() -> UIScrollView? {
        return view.viewWithTag(100) as? UIScrollView
    }
    
}
