//
//  XYNavigationController.swift
//  Arrietty
//
//  Created by mofeini on 16/12/4.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

class XYNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override class func initialize() -> Void {
        
        if self == XYNavigationController.self {
            
            let bar = UINavigationBar.appearance()
            bar.setBackgroundImage(UIImage.xy_imageWithColor(color: kAppTinColor), for: .default)
            
            // 设置导航条title的属性
            let font : UIFont?
            
            if #available(iOS 8.2, *) {
                font = UIFont.systemFont(ofSize: 18, weight: 0.1)
                
            } else {
                font = UIFont.systemFont(ofSize: 18)
            }
            bar.titleTextAttributes = [NSFontAttributeName : font!, NSForegroundColorAttributeName : UIColor.white]
            
            // 设置导航栏为黑色样式，目的是让状态栏中的子控件颜色为白色
            bar.barStyle = .black;
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let target = self.interactivePopGestureRecognizer?.delegate
        self.interactivePopGestureRecognizer?.isEnabled = false
        
        let pan = UIPanGestureRecognizer(target: target, action: Selector("handleNavigationTransition:"))
        self.view.addGestureRecognizer(pan)
        
        pan.delegate = self;
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let backBtn = UIButton()
            backBtn.setImage(UIImage.init(named: "NavigatorBack"), for: .normal)
            backBtn.sizeToFit()
            backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            
            
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func backBtnClick() -> Void {
        
        // 判断两种情况: push 和 present
        if ((self.presentedViewController != nil) || self.presentingViewController != nil) && self.childViewControllers.count == 1 {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.popViewController(animated: true)
        }
       
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        ///判断是否是根控制器
        if self.childViewControllers.count == 1
        {
            return false
        }  
        return true
    }

}
