//
//  XYArticleItem.swift
//  Arrietty
//
//  Created by mofeini on 16/12/5.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  物品模型类型

import UIKit

class XYArticleItem: NSObject {

    var itemId : Int?            // 物品ID
    var title : String?          // 物品标题
    var description_ : String?   // 物品描述, 原字段description，与系统关键字有冲突
    var createTime : String?     // 物品创建时间
    var dailyPrice : Int?        // 物品市场价格
    var userId : Int?            // 用户ID
    var longitude : Double?      // 物品所在经度
    var latitude : Double?       // 纬度
    var geohash : String?        // 将二维的经纬度转换成字符串
    var province : String?       // 省份
    var city : String?           // 城市
    var location : String?       // 位置
    var deposit : Int?           // 物品借用的押金金额
    var status : Int?            // 物品借用状态，0未借用
    var imageCover : String?     // 物品头像
    var gallery : [String]?      // 物品图的数组
    var owner : XYOwnerItem?     // 物品的所有者(发布物品的用户)
    var tag : String?            // 物品的标签
    var standardTag : String?    // 标签
    var averageRate : Int?
    var totalComments : Int?
    var totalDiscussions : Int?  // 物品总评论次数
    var maxRentDays : Int?       // 物品出租的天数
    var isHidden : Int?
    var hasDel : Int?            // 物品是否已删除，0代表未删掉，1代表删除
    var renterId : Int?          // 承租人ID
    var favorite : Int?          // 当前登录的用户是否喜欢此物品
    
    
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
        
        self.maxRentDays = dict["maxRentDays"] as? Int
        self.totalDiscussions = dict["totalDiscussions"] as? Int
        self.deposit = dict["deposit"] as? Int
        self.longitude = dict["longitude"] as? Double
        self.latitude = dict["latitude"] as? Double
        
        if let own = dict["owner"] {
            self.owner = XYOwnerItem(dict: own as! [String : Any])
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        if key == "description" {
            self.description_ = value as! String?
        }
    }
    
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["title", "description_", "createTime"]).description
    }
    
    
}
