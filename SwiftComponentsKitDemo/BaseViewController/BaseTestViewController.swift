//
//  BaseTestViewController.swift
//  SwiftComponentsKitDemo
//
//  Created by lax on 2022/9/21.
//

import UIKit
import SwiftComponentsKit

class BaseTestViewController: TipsTestViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        showNavigationBar = true
        navigationBar?.titleLabel?.text = "hello"
        
    }

}
