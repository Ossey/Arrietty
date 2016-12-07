//
//  XYSpecial.swift
//  Arrietty
//
//  Created by mofeini on 16/12/5.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  专题活动模型类

import UIKit


class XYSpecial: NSObject {

    // MARK:- 属性
    var scId : Int?
    var title : String?             // 专题活动标题
    var subTitle : String?          // 专题活动子标题
    var desc : String?              // 专题活动描述
    var smallPicUrl : String?
    var largePicUrl : String?
    var mainPicUrl : String?        // 专题详情页的头部图片
    var createTime : String?        // 创建时间
    var pubTime : String?           // 出版时间
    var weight : Int?
    var hitCount : Int?
    var hasDel : Int?
    var threadId : Int?
    var chosen : Int?
    var itemList : [XYArticleItem] = [XYArticleItem]()    // 专题活动的物品模型数组
    
    
    // MARK:- 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        if let list = dict["itemList"] as? [[String : Any]] {
            for obj in list {
                let articleItem = (XYArticleItem(dict: obj))
                
                itemList.append(articleItem)
            }
        }
        
        self.scId = dict["scId"] as! Int?
        self.title = dict["title"] as! String?
        self.subTitle = dict["subTitle"] as! String?
        self.desc = dict["desc"] as! String?
        self.smallPicUrl = dict["smallPicUrl"] as! String?
        self.largePicUrl = dict["largePicUrl"] as! String?
        self.mainPicUrl = dict["mainPicUrl"] as! String?
        self.createTime = dict["createTime"] as! String?
        self.pubTime = dict["pubTime"] as! String?
        self.weight = dict["weight"] as! Int?
        self.hitCount = dict["hitCount"] as! Int?
        self.hasDel = dict["hasDel"] as! Int?
        self.threadId = dict["threadId"] as! Int?
        self.chosen = dict["chosen"] as! Int?
    }
    
}
