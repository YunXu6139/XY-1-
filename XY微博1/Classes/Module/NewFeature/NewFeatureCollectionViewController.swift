//
//  NewFeatureCollectionViewController.swift
//  XY微博1
//
//  Created by xuyun on 15/8/6.
//  Copyright © 2015年 xuyun. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewFeatureCollectionViewController: UICollectionViewController {
    private let imageCount = 4
    private let layout = XYFlowLayout()
    init() {
        super.init(collectionViewLayout: layout)
        
    
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

         self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCount
    }


    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
    
        // Configure the cell
        cell.imageIndex = indexPath.item
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let path = collectionView.indexPathsForVisibleItems().last!
        if path.item == imageCount - 1 {
            let cell = collectionView.cellForItemAtIndexPath(path) as! NewFeatureCell
            cell.startBtnAnimation()
        }
    }
}


class NewFeatureCell: UICollectionViewCell {
    private var imageIndex: Int = 0 {
        didSet{
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            startBtn.hidden = true
        }
    }
    
    func clickStartBtn() {
        
    
    
    }
    
    private func startBtnAnimation() {
        startBtn.hidden = false
        startBtn.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startBtn.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                
        }
    }
    //MARK: - 懒加载控件
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder )
        prepareUI()
    }
    
    private func prepareUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(startBtn)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview": iconView]))
        contentView .addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview": iconView]))
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: startBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: startBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -160))
    
    }
    
    private lazy var iconView = UIImageView()
    private lazy var startBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        btn.setTitle("开始体验", forState: UIControlState.Normal)
        btn.sizeToFit()
        btn.addTarget(self, action: "clickStartBtn", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
}
    
private class XYFlowLayout: UICollectionViewFlowLayout {
    private override func prepareLayout() {
        itemSize = collectionView!.bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
    }
  
    
    
    
}