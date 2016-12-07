//
//  XYArticleDetailBaseController.swift
//  Arrietty
//
//  Created by mofeini on 16/12/5.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  物品详情控制器

import UIKit

class XYArticleDetailBaseController: UIViewController {

    private lazy var bottomView : XYArticleDetailBottomView = {
        let view = XYArticleDetailBottomView()
        view.backgroundColor = UIColor.init(white: 1.0, alpha: 0.8)
        return view
    }()
    
    private lazy var containerView : UIScrollView = {
        let scrollView =  UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        /// 让scrollView不能滚动
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    private var isInitialize : Bool = false
    
    private var titleView : XYArticleDetailTitleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isInitialize == false {
            
            addTitleView()
            isInitialize = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        /// 由于titleView和当前控制器产生循环引用关系，导致无法正常释放，所以这里手动释放
        self.titleView?.removeFromSuperview()
        self.titleView = nil
        
    }


    private func addTitleView() -> Void {
        let titleView = XYArticleDetailTitleView.articleDetailView(superVc: self, callBack: {[weak self] (type, btn) in
            
            self?.addChildVc(index: btn.tag)
            self?.containerView.contentSize = CGSize(width: CGFloat(btn.tag) * UIScreen.main.bounds.width, height: 0)
            
            // 内容滚动范围滚动到对应的位置
            self?.containerView.contentOffset = CGPoint.init(x: CGFloat(btn.tag) * UIScreen.main.bounds.width, y: 0)
        })
        self.titleView = titleView
        titleView.backgroundColor = UIColor.white
        self.view.addSubview(titleView)
        
        
    }
    
    private func setupUI() -> Void {
        
        self.title = "物品详情"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(containerView)
        self.view.addSubview(bottomView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        containerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo((titleView?.snp.bottom)!)

        }
        
        titleView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(44)
        })
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(60)
        }
        
    }
    
    /// 添加对应的子控制器
    private func addChildVc(index: Int) -> Void {
    
        let vc = self.childViewControllers[index]
        
        if (vc.view.superview != nil) || (vc.view.window != nil) {
            return
        }
        
        let x = CGFloat(index) * self.view.frame.width;
        
        self.containerView.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView).offset(x)
            make.top.width.height.equalTo(self.containerView)
        }
        
        
    }
    
    deinit {
        print("XYArticleDetailController已释放")
    }
   
}
