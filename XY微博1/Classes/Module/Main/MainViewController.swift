//
//  MainViewController.swift
//  XY微博1
//
//  Created by xuyun on 15/8/1.
//  Copyright © 2015年 xuyun. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()
        //print(tabBar.subviews)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        layoutBtn()
    }
    
    private func addChildViewControllers(){
        
        addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(UIViewController())
        addChildViewController(DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    
    private func addChildViewController(vc: UIViewController, title: String, imageName: String){
        
        //tabBar.tintColor = UIColor.orangeColor()
        //let vc = HomeViewController()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
    }
    
    lazy private var composedBtn: UIButton = {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(self, action: "composedBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
        }()
    
    func composedBtnClick() {
        print("composedBtnClick")
        
    }
    
    func layoutBtn() {
        
        let width: CGFloat = tabBar.bounds.width / CGFloat(viewControllers!.count)
        let height: CGFloat = tabBar.bounds.height
        let x: CGFloat = 2 * width
        composedBtn.frame = CGRectMake(x, 0, width, height)
        tabBar.addSubview(composedBtn)
    }
}
