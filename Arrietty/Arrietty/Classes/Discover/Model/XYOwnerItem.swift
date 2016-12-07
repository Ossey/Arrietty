//
//  XYOwnerItem.swift
//  Arrietty
//
//  Created by mofeini on 16/12/5.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  物品所有者模型类

import UIKit

class XYOwnerItem: NSObject {

    var userId : Int?          // 用户ID
    var nickname : String?     // 用户昵称
    var avatar : String?       // 头像url
    var longitude : Double?    // 经度
    var latitude : Double?     // 纬度
    var isFollowing : Bool?    // 是否关注
    var sex : Int?             // 性别   -1是男
    var black : Int?           //
    var allowNearbyRequestPush : Int?  // 是否允许附近请求推送 1代表允许
    var allowSameInterestRequestPush : Int?  // 是否允许相同的兴趣请求推送 1代表允许
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
