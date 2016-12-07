//
//  XYArriettyRegulationController.swift
//  Arrietty
//
//  Created by mofeini on 16/12/6.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  物品借用规则控制器

import UIKit

class XYArriettyRegulationController: UIViewController {
    
    var articleItem : XYArticleItem? {
        didSet {
        }
    }

    /// 借用规则头部的视图
    private lazy var headerView : XYArriettyRequlationHeaderView = {
        let headerView = XYArriettyRequlationHeaderView.xy_viewFromNib(articleItem: self.articleItem!)
        return headerView
    }()
    
    /// 地图
    private lazy var mapView : MAMapView = {
        let mapView = MAMapView.init()
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.zoomLevel = 15.0
        mapView.delegate = self
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        
        self.view.addSubview(mapView)
        return mapView
    }()
    
    /// 地理编码显示的label
    private lazy var geocoderLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    
    
    var scrollView : UIScrollView!
    
    override func loadView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 88)
        self.view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// 设置地图默认显示的中心点--把经纬度坐标赋给地图的中心点
        mapView.centerCoordinate = CLLocationCoordinate2DMake((self.articleItem?.latitude)!, (self.articleItem?.longitude)!)
        /// Add a annotation on map center 当前地图的中心点经纬度坐标
        addAnnotationWithCooordinate(coordinate: mapView.centerCoordinate)
        /// 设置当前地图的缩放级别
        mapView.setZoomLevel(14.0, animated: false)
        
        var geocoderLabelframe = geocoderLabel.frame
        geocoderLabelframe.origin.x = 10
        geocoderLabelframe.size.width = mapView.frame.width
        geocoderLabelframe.origin.y = mapView.frame.maxY + 10
        geocoderLabel.frame = geocoderLabelframe
        
        /// 反地理编码
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: (self.articleItem?.latitude)!, longitude: (self.articleItem?.longitude)!)
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemark, error) in
            if error != nil {
                self.geocoderLabel.text = "由于用户关闭了定位，享借无法获取用户位置"
            }
            
//            print(Thread.current)
            /// 打印结果
            if let name = placemark?[0].name {
                self.geocoderLabel.text = name
                print(name)
                print()
            }
            
            self.geocoderLabel.sizeToFit()
        })
        

    }
    
    func setupUI() -> Void {
        view.addSubview(headerView)
        view.addSubview(mapView)
        view.addSubview(geocoderLabel)
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: scrollView.contentSize.height + 5)
        
    }
    
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 160)
    
        let padding = CGFloat(10.0)
        mapView.frame = CGRect(x:padding , y: headerView.frame.maxY + 30, width: view.frame.width - padding, height: 180)
        
        
    }

    /// 添加大头针到地图的某个位置
    private func addAnnotationWithCooordinate(coordinate: CLLocationCoordinate2D) -> Void {
    
        let annotation = MAPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    

}


extension XYArriettyRegulationController: MAMapViewDelegate {
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation is MAPointAnnotation {
            let customReuseIndetifier: String = "customReuseIndetifier"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: customReuseIndetifier) as? XYCustomAnnotationView
            
            if annotationView == nil {
                annotationView = XYCustomAnnotationView.init(annotation: annotation, reuseIdentifier: customReuseIndetifier)
                
                annotationView?.canShowCallout = false
                annotationView?.isDraggable = true
            }
            
            annotationView?.articleItem = articleItem
            return annotationView
        }
        
        return nil
    }
}


