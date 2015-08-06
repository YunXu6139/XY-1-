//
//  VisitorView.swift
//  XY微博1
//
//  Created by xuyun on 15/8/1.
//  Copyright © 2015年 xuyun. All rights reserved.
//

import UIKit

protocol VisitorViewDelegate: NSObjectProtocol {
    
    func visitorWillRegister();
    func visitorWillLogin();
    
}
class VisitorView: UIView {
    
    
    weak var delegate: VisitorViewDelegate?
    //设置访客视图
    func setupInfo(isHome: Bool, imageName: String, message: String) {
        txtLabel.text = message
        rotationView.image = UIImage(named: imageName)
        if isHome {
            rotateView()
        }else{
            homeView.hidden = true
            sendSubviewToBack(maskIconView)
        }
        
    }
    
    func rotateView() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        anim.removedOnCompletion = false
        rotationView.layer.addAnimation(anim, forKey: nil)
    }
    
    func clickRegisterBtn() {
        delegate?.visitorWillRegister()
    }
    
    func clickLoginBtn() {
        delegate?.visitorWillLogin()
    }
    //MARK: - 界面初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    //设置界面
    private func setupUI() {
        
        addSubview(rotationView)
        addSubview(maskIconView)
        addSubview(homeView)
        addSubview(txtLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        //旋转视图
        rotationView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: rotationView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: rotationView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -100))
        //小房子
        homeView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
        //文本
        txtLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: txtLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: txtLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        //按钮
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: txtLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: txtLabel, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 80))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40))
        //按钮
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: txtLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: txtLabel, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 80))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40))
        //遮罩视图
        maskIconView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: registerBtn, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        self.backgroundColor = UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1)
    }
    
    // MARK: - 懒加载
    private lazy var rotationView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return imgView
        }()
    private lazy var maskIconView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return imgView
        }()
    private lazy var homeView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return imgView
        }()
    private lazy var txtLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜"
        lbl.textColor = UIColor.darkGrayColor()
        lbl.font = UIFont.systemFontOfSize(15)
        lbl.preferredMaxLayoutWidth = 200
        lbl.numberOfLines = 0
        return lbl
        }()
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.addTarget(self, action: "clickLoginBtn", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
        }()
    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.addTarget(self, action: "clickRegisterBtn", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
        }()
    
}

