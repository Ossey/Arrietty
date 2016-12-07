//
//  XYRecommendArticleCell.swift
//  Arrietty
//
//  Created by mofeini on 16/12/5.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  推荐物品cell，根据登录用户的兴趣推荐物品

import UIKit

class XYRecommendArticleCell: UITableViewCell {

    private lazy var iconView : UIImageView = {
        let iconView = UIImageView()
        iconView.backgroundColor = UIColor.red
        return iconView
    }()
    
    private lazy var coverView : UIButton = {
        let coverView = UIButton()
        coverView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
        coverView.setBackgroundImage(UIImage.xy_imageWithColor(color: UIColor(red: 198/255.0, green: 199/255.0, blue: 199/255.0, alpha: 1.0)), for: .highlighted)
        return coverView
    }()
    
    /// 物品标题
    private lazy var articleTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "纯天然1.5宽度羚羊角 手镯"
        label.font = kDiscoverHeaderFont
        return label
    }()
    
    /// 物品押金
    private lazy var depositMoneyLabel : UILabel = {
        let label = UILabel()
        label.text = "押金 180元"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    /// 物品距离我的距离
    private lazy var distanceLable : UILabel = {
        let label = UILabel()
        label.text = "距离 1617.9km"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() -> Void {
        
        contentView.addSubview(coverView)
        coverView.addSubview(iconView)
        coverView.addSubview(articleTitleLabel)
        coverView.addSubview(depositMoneyLabel)
        coverView.addSubview(distanceLable)
        
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = 10.0
        coverView.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(padding)
            make.right.equalTo(contentView).offset(-padding)
            make.bottom.equalTo(contentView)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.coverView)
            make.width.equalTo(self.iconView.snp.height)
        }
        
        articleTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(padding)
            make.top.equalTo(coverView).offset(padding)
        }
        
        distanceLable.snp.makeConstraints { (make) in
            make.bottom.equalTo(coverView).offset(-padding)
            make.left.equalTo(articleTitleLabel)
        }
        depositMoneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(articleTitleLabel)
            make.bottom.equalTo(distanceLable.snp.top).offset(-padding)
        }
        
    }
}


class XYRecommendArticlFootView: UITableViewHeaderFooterView {
    /// 显示聚类类别的label
    private lazy var clusterBtn : UIButton = {
        let clusterBtn = UIButton()
        clusterBtn.setTitle("来自# 旅游", for: .normal)
        clusterBtn.setTitleColor(kAppTinColor, for: .normal)
        clusterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return clusterBtn
    }()
    
    /// 切换下一个
    private lazy var changeNextBtn : UIButton = {
        let btn = UIButton()
        btn .setTitle("换下一个", for: .normal)
        btn.titleLabel?.font = kDiscoverHeaderFont
        btn.setTitleColor(kAppTinColor, for: .normal)
        return btn
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(changeNextBtn)
        contentView.addSubview(clusterBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = 10.0
        clusterBtn.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(padding)
            make.top.bottom.equalTo(contentView)
        }
        
        changeNextBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-padding)
            make.top.bottom.equalTo(clusterBtn)
        }
    }

}
