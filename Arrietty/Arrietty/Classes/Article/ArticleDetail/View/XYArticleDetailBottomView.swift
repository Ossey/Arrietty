//
//  XYArticleDetailBottomView.swift
//  Arrietty
//
//  Created by mofeini on 16/12/6.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

class XYArticleDetailBottomView: UIView {

    /// 显示押金金额的按钮
    private lazy var depositBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("押金 500元", for: .normal)
        btn.setTitleColor(kAppTinColor, for: .normal)
        btn.setImage(UIImage.init(named: "note"), for: .normal)
        return btn
    }()
    
    /// 我想借按钮
    private lazy var arriettyBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("我想借", for: .normal)
        btn.backgroundColor = kAppTinColor
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(depositBtn)
        self.addSubview(arriettyBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        depositBtn.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        arriettyBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.bottom.top.equalTo(depositBtn)
            make.width.equalTo(120)
        }
    }

}
