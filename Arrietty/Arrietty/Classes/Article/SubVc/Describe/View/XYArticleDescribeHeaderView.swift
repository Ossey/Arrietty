//
//  XYArticleDescribeHeaderView.swift
//  Arrietty
//
//  Created by mofeini on 16/12/5.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  物品介绍界面的头部视图

import UIKit

class XYArticleDescribeHeaderView: UIView {

    // MARK: - 控件属性
    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var headerView: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var privateMessageBtn: UIButton!
    
    /// 模型
    var articleItem : XYArticleItem? {
        didSet {
            
            self.articleName.text = articleItem?.title
            self.descriptionLabel.text = articleItem?.description_
            self.nickName.text = articleItem?.owner?.nickname
            if let imageURL = URL.init(string: (articleItem?.owner?.avatar)!) {
                self.headerView.kf.setImage(with: imageURL, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                    
                    self.headerView.image = image?.xy_circleImage()
                })
            }
            
        }
    }
    
    class func xy_viewFromNib() -> XYArticleDescribeHeaderView {
        
         return Bundle.main.loadNibNamed("XYArticleDescribeHeaderView", owner: nil, options: nil)?.first as! XYArticleDescribeHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    

  
    private func setupUI() -> Void {
        
        privateMessageBtn.layer.cornerRadius = privateMessageBtn.frame.height * 0.5
        privateMessageBtn.layer.masksToBounds = true
        
    }
    
    
    
}
