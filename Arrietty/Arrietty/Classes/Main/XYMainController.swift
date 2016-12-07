//
//  XYMainController.swift
//  Arrietty
//
//  Created by mofeini on 16/12/4.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

class XYMainController: UITabBarController {

    override class func initialize() {
        if self == XYMainController.self  {
            
            let tabBar = UITabBar.appearance()
            tabBar.tintColor = kAppTinColor
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChlidVc()
    }
}

extension XYMainController {
    
    func addChlidVc() -> Void {
        
        let disVc =  XYDiscoverController.init(style: .grouped);
        let nav1 = XYNavigationController(rootViewController: disVc)
        disVc.tabBarItem.image = UIImage(named: "TabHome")
        disVc.tabBarItem.selectedImage = UIImage(named: "TabHomeSelected")
        disVc.tabBarItem.title = "发现"
        self.addChildViewController(nav1)
        
        let sameCityVc = XYSameCityController()
        let nav2 = XYNavigationController(rootViewController: sameCityVc)
        sameCityVc.tabBarItem.image = UIImage(named: "TabExplore")
        sameCityVc.tabBarItem.selectedImage = UIImage(named: "TabExploreSelected")
        sameCityVc.tabBarItem.title = "同城"
        self.addChildViewController(nav2)
        
        let messageVc = XYMessageController()
        let nav3 = XYNavigationController(rootViewController: messageVc)
        messageVc.tabBarItem.image = UIImage(named: "TabShare")
        messageVc.tabBarItem.selectedImage = UIImage(named: "TabShareSelected")
        messageVc.tabBarItem.title = "消息"
        self.addChildViewController(nav3)
        
        let profileVc = XYProfileController()
        let nav4 = XYNavigationController(rootViewController: profileVc)
        profileVc.tabBarItem.image = UIImage(named: "TabMe")
        profileVc.tabBarItem.selectedImage = UIImage(named: "TabMeSelected")
        profileVc.tabBarItem.title = "我"
        self.addChildViewController(nav4)
    }
}
