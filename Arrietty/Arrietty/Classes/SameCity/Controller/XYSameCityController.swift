//
//  XYSameCityController.swift
//  Arrietty
//
//  Created by mofeini on 16/12/4.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

class XYSameCityController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

    func setupNavigationBar() -> Void {
        // 左
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "NavigatorSearch"), for: .normal)
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        // 左
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "NavigatorAdd"), for: .normal)
        rightBtn.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        navigationItem.title = "北京"
    }

}
