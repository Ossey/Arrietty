//
//  XYArticleDetailTitleView.swift
//  Arrietty
//
//  Created by mofeini on 16/12/5.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

enum XYArticleDetailType: Int {
    case describe = 0  // 物品描述
    case policy        // 物品原则
    case story         // 物品故事
}

typealias ArticleDetailCallBack = ((XYArticleDetailType, UIButton) -> ())

class XYArticleDetailTitleView: UIView {

    // MARK: - 对外开放的方法及属性
    /// 点击标题按钮的回调，根据XYArticleDetailType判断
    public var titleBtnCallBack: ArticleDetailCallBack?
    private var superVc : UIViewController?
    
    /// 此方法返回当前类对象，并对三个按钮的点击事件进行回调，通过XYArticleDetailType判断即可
    public class func articleDetailView(superVc: UIViewController, callBack: @escaping ArticleDetailCallBack) ->XYArticleDetailTitleView {
        let view = XYArticleDetailTitleView(frame: .zero)
        view.titleBtnCallBack = callBack
        view.superVc = superVc
        
        view.setupUI()
        return view;
    }
    
    // MARK: - 属性
    private lazy var titles : [String] = {
        var titles = [String]()
        return titles
    }()
    /// 存放标题按钮的数组
    private var titleBtns : [UIButton] = [UIButton]()
    /// 分割线
    private lazy var separatorLine : UIView = {
        let line = UIView()
        line.backgroundColor = kGlobalSeparatorLine
        return line
    }()
    
    /// 下划线
    private lazy var underLine : UIView = {
        let line = UIView()
        line.backgroundColor = kAppTinColor
//        line.frame = CGRect(x: self.btnContentMargin, y: 44 - 2, width: self.btnTitleLabelWidth, height: 2)
        return line
    }()
    
    /// 上传选中的按钮
    private var previousSelectBtn : UIButton?
    /// 当前选中的按钮
    private var currentSelectBtn : UIButton?
    /// 按钮中label的宽度的计算属性
    private var btnTitleLabelWidth : CGFloat {
        get {
            let currentText = self.currentSelectBtn?.titleLabel?.text
            if let title = currentText as? NSString {
                let attributes = [NSFontAttributeName: kDiscoverHeaderFont]
                let size = title.size(attributes: attributes)
                return size.width
            }
            return 0
        }
    }
    
    /// 按钮中label与按钮左右的间距的计算属性
    private var btnContentMargin : CGFloat {
        get {
            let btnW = UIScreen.main.bounds.width / CGFloat(titles.count)
            let btnMargin = (btnW - btnTitleLabelWidth) * 0.5
            return btnMargin
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() -> Void {
    
        guard let count = superVc?.childViewControllers.count else {
            print("没有子控制器")
            return
        }
        
        /// 此时self的frame没有值
        for i in 0..<count{
            let btn = UIButton()
            
            guard let childs = superVc?.childViewControllers else {
                return
            }
            guard let title = childs[i].title else {
                return
            }
            
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor(red: 152/255.0, green: 152/255.0, blue: 152/255.0, alpha: 1.0), for: .normal)
            titleBtns.append(btn)
            btn.titleLabel?.font = kDiscoverHeaderFont
            self.addSubview(btn)
            btn.addTarget(self, action: #selector(titleBtnClick(btn:)), for: .touchUpInside)
            btn.tag = i
            if i == 0 {
                self.titleBtnClick(btn: btn)
                
            }
            self.titles.append(title)
        }
        
        self.addSubview(separatorLine)
        self.addSubview(underLine)
        /// 需要在这里设置下underLine的frame，不然第一次进入当前界面underLine的frame不准确无法显示
        underLine.frame = CGRect(x: self.btnContentMargin, y: 44 - 2, width: self.btnTitleLabelWidth, height: 2)
        

    }
    
    // MARK: - Event
    @objc private func titleBtnClick(btn: UIButton) ->Void {
        self.currentSelectBtn = btn
        self.previousSelectBtn?.isSelected = false
        btn.isSelected = true
        self.previousSelectBtn = btn
        
        UIView.animate(withDuration: 0.2, animations: {
            
            var frame = self.underLine.frame
            frame.size.width = self.btnTitleLabelWidth
            frame.origin.x = btn.frame.origin.x + self.btnContentMargin
            self.underLine.frame = frame
            
        })
        
        /// 执行闭包
        if self.titleBtnCallBack != nil {
            self.titleBtnCallBack!(XYArticleDetailType(rawValue: btn.tag)!, btn)
        }

    }
    
    override func layoutSubviews() {
        
        let btnW = self.frame.width / CGFloat(titles.count)
        let btnH = self.frame.height
        var btnX = CGFloat(0.0)
        let btnY = CGFloat(0.0)
        
        for i in 0..<titleBtns.count {
        
            let btn = titleBtns[i]
            btnX = CGFloat(i) * btnW
            
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            
        }
        separatorLine.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1)
        
        
        
    }
    
    deinit {
        print("XYArticleDetailTitleView已释放")
    }
    
}
