//
//  XYHotClusterCell.swift
//  Arrietty
//
//  Created by mofeini on 16/12/4.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  热门聚类cell

import UIKit

class XYHotClusterCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK:- 属性
    private lazy var tipLabel : UILabel = {
        
        let label = UILabel()
        label.text = "你正在打算..."
        label.font = kDiscoverHeaderFont
        return label
    }()
    
    private lazy var moreBtn : UIButton = {
        let moreBtn = UIButton()
        moreBtn.setTitle("查看更多", for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        moreBtn.setTitleColor(kAppTinColor, for: .normal)
        return moreBtn
    }()
    
    private lazy var collectionView : XYHotClusterCollectionView = {
        let flowLayout = XYHotClusterFlowLayout()
        
        let collectionView = XYHotClusterCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false; // 让scrollView不可以滑动
        collectionView.backgroundColor = UIColor.white
        return collectionView
        
    }()
    
    // MARK:- 热门聚类模型
    var clusterItems : [XYClusterItem]? = [XYClusterItem]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        contentView.addSubview(tipLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(moreBtn)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(XYHotClusterCollectionViewCell.self, forCellWithReuseIdentifier: "XYHotClusterCollectionViewCell")
        
        self.selectionStyle = .none
    }

    override func layoutSubviews() {
         super.layoutSubviews()
        
        tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(contentView).offset(10)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.centerX.equalTo(collectionView)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(tipLabel.snp.bottom).offset(10)
            make.left.equalTo(tipLabel)
            make.right.equalTo(contentView).offset(-10)
        }
        
        
    }
    
}

extension XYHotClusterCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.clusterItems!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XYHotClusterCollectionViewCell", for: indexPath) as! XYHotClusterCollectionViewCell
    
        cell.clusterItem = self.clusterItems?[indexPath.row]
        
        return cell
    }
}


/// 展示热门聚类的collectionView
class XYHotClusterCollectionView: UICollectionView {
    
}

/// 展示热门聚类的collectionViewCell
class XYHotClusterCollectionViewCell: UICollectionViewCell {
    
    // MARK:- 属性
    private lazy var backGroundImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var alias_label : UILabel = {
        let label = UILabel()
        label.text = "出门旅行"
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "借本LP再出门"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        return label
    }()
    
    // MARK:- 热门聚类模型
    var clusterItem : XYClusterItem? {
        didSet {
            
            alias_label.text = clusterItem?.alias
            descriptionLabel.text = clusterItem?.description_
            guard let imageUrl = clusterItem?.picUrl else {
                print("imageURL没有数据")
                return
            }
            backGroundImageView.kf.setImage(with: URL.init(string: imageUrl))
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backGroundImageView)
        backGroundImageView.addSubview(alias_label)
        backGroundImageView.addSubview(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = 10.0
        backGroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        alias_label.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.backGroundImageView).offset(padding)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(alias_label)
            make.top.equalTo(alias_label.snp.bottom).offset(padding * 0.5)
        }
    }
}


class XYHotClusterFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        let width = (self.collectionView?.frame.width)! * 0.5  - 5
        let height = (self.collectionView?.frame.height)! / 3
        
        self.itemSize = CGSize(width: width, height: height)
        self.minimumLineSpacing = 5
        self.minimumInteritemSpacing = 5
        
    }
}

