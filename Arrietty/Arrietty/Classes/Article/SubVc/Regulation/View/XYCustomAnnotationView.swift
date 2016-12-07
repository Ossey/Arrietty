//
//  XYCustomAnnotationView.swift
//  Arrietty
//
//  Created by mofeini on 16/12/6.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

class XYCustomAnnotationView: MAAnnotationView {

    private let kWidth : CGFloat = 26.0
    private let kHeight : CGFloat = 36.0
    
    private let kHoriMargin : CGFloat = 5.0
    private let kVertMargin : CGFloat = 5.0
    
    private let kPortraitWidth : CGFloat = 26.0
    private let kPortraitHeight : CGFloat = 36.0
    
    /// 物品模型
    var articleItem : XYArticleItem? {
        didSet {
            
            guard let imageURL = articleItem?.owner?.avatar else {
                return
            }
 
            self.iconView.kf.setImage(with: URL.init(string: imageURL), placeholder: UIImage.init(named: "AvatarPlaceholder_43"), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: {image , error, cacheType, imageURL in
                
                self.iconView.image = image?.xy_circleImage()
            })
        }
    }
    
    open var headerImage : UIImage? {
        set {
            iconView.image = headerImage
        }
        
        get {
            return iconView.image
        }
    }
    
    open var backgroundImage : UIImage? {
        
        set {
            backgroundImageView.image = backgroundImage
        }
        get {
            return backgroundImageView.image
        }
    }
    
    
    private lazy var backgroundImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MapLocation")
        
        return imageView
    }()
    
    private lazy var iconView : UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    
    
    // MARK: - Life Cycle
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.bounds = CGRect(x: 0.0, y: 0.0, width: kWidth, height: kHeight)
        self.backgroundColor = UIColor.clear
        
    
        self.addSubview(backgroundImageView)
        self.backgroundImageView.frame = CGRect(x: kHoriMargin, y: kVertMargin, width: kPortraitWidth, height: kPortraitHeight)
        /* 创建iconView展示用户头像 */
        self.backgroundImageView.addSubview(iconView)
        iconView.frame = CGRect(x: kHoriMargin-4, y: kVertMargin-3, width: kPortraitWidth-2, height: kPortraitWidth-2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

}

