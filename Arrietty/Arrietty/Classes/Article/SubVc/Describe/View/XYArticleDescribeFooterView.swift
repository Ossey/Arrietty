//
//  XYArticleDescribeFooterView.swift
//  Arrietty
//
//  Created by mofeini on 16/12/6.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

class XYArticleDescribeFooterView: UITableViewHeaderFooterView {

    /// 添加评论按钮
    private lazy var addCommentBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("+添加评论", for: .normal)
        btn.setTitleColor(kAppTinColor, for: .normal)
        btn.backgroundColor = UIColor.init(red: 221/255.0, green: 246/255.0, blue: 242/255.0, alpha: 1.0)
        return btn
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() ->Void {
        
        self.contentView.addSubview(addCommentBtn)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCommentBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(0)
            make.right.equalTo(self.contentView).offset(0)
            make.top.bottom.equalTo(self.contentView)
        }
    }

}
