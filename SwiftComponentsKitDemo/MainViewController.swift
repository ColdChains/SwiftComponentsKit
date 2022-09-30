//
//  ViewController.swift
//  SwiftComponentsKitDemo
//
//  Created by lax on 2022/8/3.
//

import UIKit
import SwiftBaseKit
import SwiftComponentsKit

class MainViewController: ViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets()
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        showNavigationBar = true
        navigationBar?.leftItem = nil
        navigationBar?.titleLabel?.text = "SwiftComponentsKitDemo"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: NavigationBarHeight, left: 0, bottom: 0, right: 0))
        }
        
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className) ?? UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.className)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "BaseViewController"
        case 1:
            cell.textLabel?.text = "MenuBarController"
        case 2:
            cell.textLabel?.text = "PresentMenuBarController"
        case 3:
            cell.textLabel?.text = "RecycleView"
        case 4:
            cell.textLabel?.text = "TipsView"
        default:
            break
        }
        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(BaseTestViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(MenuBarTestViewController(), animated: true)
        case 2:
            // 自定义topView
            let bar = UIView(frame: CGRect(x: (UIScreen.main.bounds.size.width - 30) / 2, y: 10, width: 30, height: 4))
            bar.backgroundColor = .lightGray
            bar.layer.cornerRadius = 2
            let topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
            topView.backgroundColor = .yellow
            topView.addSubview(bar)
            
            let vc = PresentViewController()
            let pmbc = PresentMenuBarController()
            pmbc.menuBar = topView;
            pmbc.topCornerRadius = 16;
            pmbc.viewControllers = [vc]
            
            // 接管状态栏样式
            pmbc.modalPresentationStyle = .custom
            pmbc.modalPresentationCapturesStatusBarAppearance = true
            present(pmbc, animated: true, completion: nil)
        case 3:
            navigationController?.pushViewController(RecycleTestViewController(), animated: true)
        case 4:
            navigationController?.pushViewController(TipsTestViewController(), animated: true)
        default:
            break
        }
        
    }
    
}
