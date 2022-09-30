//
//  MenuBarTestViewController.swift
//  SwiftComponentsKitDemo
//
//  Created by lax on 2022/9/21.
//

import UIKit
import SwiftComponentsKit

class MenuBarTestViewController: MenuBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        showNavigationBar = true
        
        // 设置顶部间距
        self.topMargin = 64;
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        headerView.backgroundColor = .green
        // 设置顶部视图
        self.headerView = headerView
        
        let footerView = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        footerView.backgroundColor = .red
        footerView.text = "FooterView"
        footerView.textAlignment = .center
        // 设置底部视图
        self.footerView = footerView
        
        let menuBar = MenuBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        menuBar.backgroundColor = .red
        menuBar.dataArray = ["MenuTab1", "MenuTab2"]
        menuBar.delegate = self
        menuBar.showUnderLineView = true
        // 设置菜单栏
        self.menuBar = menuBar
        
        // 设置子控制器
        viewControllers = [MenuBarContentViewController(), MenuBarContentViewController()]
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
