//
//  XYDiscoverController.swift
//  Arrietty
//
//  Created by mofeini on 16/12/4.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit
import Alamofire

class XYDiscoverController: UITableViewController {
    
    static let cellIdentifier: String = "XYDiscoverViewCell"
    static let headerViewIdentifier: String = "XYDiscoverHeaderView"
    /// 存放专题模型的数组
    lazy var specialList : [XYSpecial] = [XYSpecial]()
    /// 存放热门聚类的模型数组
    lazy var tagList : [XYClusterItem] = [XYClusterItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        loadData()
        setupTableView()
    }
    
}

// MARK:- UI
extension XYDiscoverController {
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
        
        navigationItem.title = "发现"
    }
    
    func setupTableView() -> Void {
        
        tableView.register(XYDiscoverViewCell.self, forCellReuseIdentifier: XYDiscoverController.cellIdentifier)
        tableView.register(XYHotClusterCell.self, forCellReuseIdentifier: "XYHotClusterCell")
        tableView.register(XYRecommendArticleCell.self, forCellReuseIdentifier: "XYRecommendArticleCell")
        tableView.register(XYDiscoverHeaderView.self, forHeaderFooterViewReuseIdentifier: XYDiscoverController.headerViewIdentifier)
        tableView.register(XYRecommendArticlFootView.self, forHeaderFooterViewReuseIdentifier: "XYRecommendArticlFootView")
        tableView.sectionFooterHeight = 10 // 设置组尾部高度
        tableView.sectionHeaderHeight = 10;
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0)
    }
    

}

extension XYDiscoverController {
    
    func loadData() -> Void {

        guard let url = URL(string: "http://api.izudian.com/home/tag_page.do?UUID=7A06D89B-A52A-4841-880E-0D328412AB44&api_version=8&platform=iOS%20%20GET%20api.izudian.com%20/home/tag_page.do?UUID=7A06D89B-A52A-4841-880E-0D328412AB44&api_version=8&platform=iOS%20Wed%20Oct%2019%2018:54:53%20CST%202016%20%20389%20Connecting%20to%20remote%20host") else {
            return
        }
        
        let request = URLRequest(url: url)
        /// 创建会话对象
        /**
         *  第一个参数:配置信息对象  [NSURLSessionConfiguration defaultSessionConfiguration]默认配置信息
         *  第二个参数:代理对象
         *  第三个参数:代理方法在哪个线程中调用
         */
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        
        // 创建任务
        let dataTask = session.dataTask(with: request)
        
        // 执行task
        dataTask.resume()
        
    }
    
}

// MARK:- URLSessionDataDelegate
extension XYDiscoverController: URLSessionDataDelegate {
    /**
     *  接收到服务器响应的时候调用 !!!!注意默认取消接收数据
     *
     *  @param session           会话对象
     *  @param dataTask          请求任务
     *  @param response          响应头信息
     *  @param completionHandler 回调,传给系统的,如果需要接收数据，需要设置completionHandler属性为接收请求
     */
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        /*
         public enum ResponseDisposition : Int {
         
         case cancel 取消请求 默认情况下通过completionHandler回调取消给系统
         
         case allow 允许请求
         
         case becomeDownload 变为下载任务
         
         @available(iOS 9.0, *)
         case becomeStream 变为流，iOS9.0以后此枚举才有效
         }
         */
        
        /// allow 接收请求
        completionHandler(.allow)
    }
    
    /**
     *  服务器返回数据的时候调用，调用多次
     *
     *  @param session  会话对象
     *  @param dataTask 请求任务
     *  @param data     本次下载的数据
     */
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let dataDict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any] else {
            print("没有数据")
            return
        }
        
//        print(Thread.current)
        
        /// 获取数据后，主线程回调，刷新表格
        DispatchQueue.main.async {
            // 专题数组
            if let specialList = dataDict["specialList"] as? [[String : Any]] {
                for special in specialList {
                    self.specialList.append(XYSpecial(dict: special))
                }
            }
            
            // 热门聚类数组
            if let tagInfo = dataDict["tagInfo"] as? [String : Any] {
                if let tagList = tagInfo["tagList"] as? [[String : Any]] {
                    for cluster in tagList {
                        self.tagList.append(XYClusterItem(dict: cluster))
                    }
                }
            }

            // 刷新数据源
            self.tableView.reloadData()
        }
    }
    /**
     *  请求结束或者失败的时候调用
     *
     *  @param session 会话对象
     *  @param task    请求任务
     *  @param error   错误信息，如果请求失败error有值
     */
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if let err = error {
            print(err.localizedDescription)
        }
    }
}

// MARK:- 数据源和代理方法
extension XYDiscoverController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 || section == 0  {
            return 1
        }
        
        
        if self.specialList.count != 0 {
        
            let specia = self.specialList[section - 2]
            return specia.itemList.count
        }
        return 0

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            /// 热门聚类cell
           let cell = tableView.dequeueReusableCell(withIdentifier: "XYHotClusterCell", for: indexPath) as! XYHotClusterCell
        
            cell.clusterItems = self.tagList
            return cell
            
            /// 推荐和兴趣相关的物品cell
        } else if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "XYRecommendArticleCell", for: indexPath) as! XYRecommendArticleCell
            
            return cell
            
        } else {
            /// 专题活动类型的cell
            let cell = tableView .dequeueReusableCell(withIdentifier: XYDiscoverController.cellIdentifier) as! XYDiscoverViewCell
            // 取出
            if self.specialList.count != 0 {
                // 对section进行-2处理，因为前两组section不需要不是专题活动
                let special = self.specialList[indexPath.section - 2]
                cell.article = special.itemList[indexPath.row]
                 
            }

            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 || section == 1  {
            return nil
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: XYDiscoverController.headerViewIdentifier) as! XYDiscoverHeaderView
        headerView.contentView.backgroundColor = UIColor.white
        
        if self.specialList.count != 0 {
        
            // 对section进行-2处理，因为前两组section不需要不是专题活动
            headerView.special = self.specialList[section - 2]
        }
        return headerView
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "XYRecommendArticlFootView") as! XYRecommendArticlFootView
            footerView.contentView.backgroundColor = UIColor.white
            return footerView
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 || section == 1 {
            return 0
        }
        return 40
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return UIScreen.main.bounds.height / 2
        }
        
        if indexPath.section == 0 {
            return 130
        }
        
        return 100

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 || indexPath.section == 3 {
            let articleDetail = XYArticleDetailController()
            let specialList = self.specialList[indexPath.section - 2]
            articleDetail.articleItem = specialList.itemList[indexPath.row]
            self.navigationController?.pushViewController(articleDetail, animated: true)
            
        }
    }
    
    
}









