//
//  DiscoveryTableViewController.swift
//  XY微博1
//
//  Created by xuyun on 15/8/1.
//  Copyright © 2015年 xuyun. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       visitorView?.setupInfo(false, imageName: "visitordiscover_image_message", message: "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜")
    }

    
}
