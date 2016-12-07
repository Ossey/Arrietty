//
//  XYArticleDetailController.swift
//  Arrietty
//
//  Created by mofeini on 16/12/6.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

class XYArticleDetailController: XYArticleDetailBaseController {
    
    var articleItem : XYArticleItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc()
    }

    private func addChildVc() -> Void {
        
        let describeVc = XYArticleDescribeController()
        describeVc.articleItem = articleItem
        describeVc.title = "物品介绍"
        self.addChildViewController(describeVc)
        
        let regulationVc = XYArriettyRegulationController()
        regulationVc.articleItem = articleItem
        regulationVc.title = "借用规则"
        self.addChildViewController(regulationVc)
        
        let storyVc = XYArriettyStoryController()
        storyVc.title = "借用故事 10"
        self.addChildViewController(storyVc)
        
    }

    
    deinit {
        print("XYArticleDetailController释放")
    }
}
