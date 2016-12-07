//
//  XYArriettyRequlationHeaderView.swift
//  Arrietty
//
//  Created by mofeini on 16/12/6.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

class XYArriettyRequlationHeaderView: UIView {

    /// 押金金额按钮
    @IBOutlet weak var depositBtn: UIButton!
    
    /// 最长出租天数按钮
    @IBOutlet weak var maxRentDaysBtn: UIButton!
    
    var articleItem : XYArticleItem? {
        didSet {
            
            if let deposit = articleItem?.deposit {
                depositBtn.setTitle("\(deposit)" + "元", for: .normal)
            }
            if let maxRentDays = articleItem?.maxRentDays {
                maxRentDaysBtn.setTitle("\(maxRentDays)" + "天", for: .normal)
            }
        }
    }
    
    class func xy_viewFromNib(articleItem: XYArticleItem) -> XYArriettyRequlationHeaderView {
        
        let view = Bundle.main.loadNibNamed("XYArriettyRequlationHeaderView", owner: nil, options: nil)?.first as! XYArriettyRequlationHeaderView
        view.articleItem = articleItem
        return view
    }

}
