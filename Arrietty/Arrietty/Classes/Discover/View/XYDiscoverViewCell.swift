//
//  XYDiscoverViewCell.swift
//  Arrietty
//
//  Created by mofeini on 16/12/4.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  专题活动cell

import UIKit
import SnapKit


/// 专题活动cell
class XYDiscoverViewCell: UITableViewCell {

    // MARK:- 属性
    lazy var iconView = UIImageView()  // 物品图像
    lazy var title_label = UILabel()   // 标题
    lazy var distanceLable = UILabel() // 距离
    lazy var commentNumberLabel = UILabel() // 评论
    lazy var headerView = UIImageView() // 用户头像
    
    // MARK:- 物品模型
    var article: XYArticleItem? {
        didSet {
            if let title = article?.title {
                title_label.text = title
            }
            commentNumberLabel.text = "\(article?.totalDiscussions)" + "评论"
           
            if let comments = article?.totalDiscussions {
                commentNumberLabel.text = "\(comments)" + "评论"
            }
            
            // 物品头像
            if let imageUrl = article?.imageCover {
                iconView.kf.setImage(with: URL.init(string: imageUrl),
                                     placeholder: UIImage(named: "AvatarPlaceholder_140"),
                                                 options: [.transition(ImageTransition.fade(1))],
                                                 progressBlock:nil,
                                                 completionHandler: { image, error, cacheType, imageURL in
                                                    
                            })
            }
            
            // 物品拥有这的用户头像
            if let headerUrl = article?.owner?.avatar {
                headerView.kf.setImage(with: URL.init(string: headerUrl),
                                       placeholder: UIImage(named: "AvatarPlaceholder_43"), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                                        
                                        // 处理为圆形图片
                                        self.headerView.image = image?.xy_circleImage()
                })
            }
            
            
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        title_label.font = kDiscoverHeaderFont
//        title_label.numberOfLines = 0
        title_label.lineBreakMode = .byTruncatingTail
        distanceLable.font = UIFont.systemFont(ofSize: 12)
        commentNumberLabel.font = UIFont.systemFont(ofSize: 12)
        distanceLable.text = "19.7km"
        
        contentView.addSubview(iconView)
        contentView.addSubview(title_label)
        contentView.addSubview(distanceLable)
        contentView.addSubview(commentNumberLabel)
        contentView.addSubview(headerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = 10
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(padding)
            make.top.equalTo(contentView).offset(padding)
            make.bottom.equalTo(contentView).offset(-padding)
            make.width.equalTo(iconView.snp.height)
        }
        
        title_label.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(padding)
            make.top.equalTo(iconView).offset(padding)
            make.right.equalTo(self.contentView).offset(-padding)
        }
        
        distanceLable.snp.makeConstraints { (make) in
            make.left.equalTo(title_label)
            make.bottom.equalTo(iconView).offset(-padding)
        }
        
        commentNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(distanceLable.snp.right).offset(2 * padding)
            make.top.bottom.equalTo(distanceLable)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-padding)
            make.centerY.equalTo(commentNumberLabel)
            make.width.height.equalTo(30)
        }
    }
}




/// 自定义tableView头部视图类
class XYDiscoverHeaderView: UITableViewHeaderFooterView {
    
    private lazy var title_label : UILabel = {
        
        let label = UILabel()
        label.text = "买前试用|试过才知中味"
        label.font = kDiscoverHeaderFont
        return label
        
    }()
    
    private lazy var rightBtn : XYDiscoverHeaderButton = {
        
        let rightBtn = XYDiscoverHeaderButton()
        rightBtn.setTitle("查看更多", for: .normal)
        rightBtn.setImage(UIImage.init(named: "AccessoryArrow"), for: .normal)
        rightBtn.setTitleColor(UIColor.lightGray, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return rightBtn
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    // MARK:- 专题模型
    var special : XYSpecial? {
        didSet {
            if let title = special?.title {
                title_label.text = title
            }
            
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        contentView.addSubview(title_label)
        contentView.addSubview(rightBtn)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = 10.0
        title_label.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(padding)
            make.centerY.equalTo(contentView)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-padding)
            make.centerY.equalTo(title_label)
        }
    }
    
}



class XYDiscoverHeaderButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 修改按钮内部子控件的frame，让图片在右边，文字在左边
        if  (imageView?.frame.origin.x)! < (titleLabel?.frame.origin.x)! {
            var titleLabelFrame = titleLabel?.frame
            titleLabelFrame?.origin.x = (imageView?.frame.origin.x)!
            titleLabel?.frame = titleLabelFrame!
            
            var imageViewFrame = imageView?.frame
            imageViewFrame?.origin.x = (titleLabelFrame?.maxX)!
            imageView?.frame = imageViewFrame!
        }
        
        
    }
}

