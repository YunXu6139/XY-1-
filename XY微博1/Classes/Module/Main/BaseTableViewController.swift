//
//  BaseTableViewController.swift
//  XY微博1
//
//  Created by xuyun on 15/8/1.
//  Copyright © 2015年 xuyun. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController, VisitorViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    var userLoginMark  = UserAccount.userLogon
    var visitorView: VisitorView?
    override func loadView() {
        
        userLoginMark ? super.loadView() : setVisitorView()
    }
    
    private func setVisitorView() {
        visitorView = VisitorView()
        visitorView?.delegate = self
        view = visitorView
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorWillRegister")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorWillLogin")
    }
    
    func visitorWillLogin() {
        let nav = UINavigationController(rootViewController: OAuthViewController())
        presentViewController(nav, animated: true, completion: nil)
    }
    
    func visitorWillRegister() {
        print("注册")
    }
    
}
