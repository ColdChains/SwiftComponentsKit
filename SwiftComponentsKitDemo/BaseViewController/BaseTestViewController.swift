//
//  BaseTestViewController.swift
//  SwiftComponentsKitDemo
//
//  Created by lax on 2022/9/21.
//

import UIKit
import SwiftComponentsKit

class BaseTestViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationBar = true
        navigationBar?.titleLabel?.text = "BaseViewController"
        
    }

}
