//
//  XYClusterItem.swift
//  Arrietty
//
//  Created by mofeini on 16/12/5.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  热门聚类模型类

import UIKit

class XYClusterItem: NSObject {

    var tag : String?           // 热门聚类类别名称
    var alias : String?         // 热门聚类类别别名
    var picUrl:  String?        // 图片URL
    var description_ : String?  // 类别描述， 原字段description，与系统关键字有冲突
    
    
    // MARK:- 自定义构造函数
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "description" {
            description_ = value as! String?
        }
    }
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["tag", "alias", "picUrl", "description_"]).description
    }
    
}
