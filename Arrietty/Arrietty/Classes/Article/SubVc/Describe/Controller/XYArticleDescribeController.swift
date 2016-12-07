//
//  XYArticleDescribeController.swift
//  Arrietty
//
//  Created by mofeini on 16/12/6.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//  物品介绍控制器

import UIKit

class XYArticleDescribeController: UIViewController {

    
    static let cellIdenftifier = "XYArticleDescribeController"
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdenftifier)
        return tableView
    }()
    
    var articleItem : XYArticleItem? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

    private func setupUI() -> Void {
        
        self.view.addSubview(tableView)
        let headerView = XYArticleDescribeHeaderView.xy_viewFromNib()
        headerView.articleItem = articleItem
        headerView.frame.size.height = tableView.frame.height - 100
        tableView.tableHeaderView = headerView
        let footerView = XYArticleDescribeFooterView()
        footerView.frame.size.height = 40
        tableView.tableFooterView = footerView
//        tableView.sectionHeaderHeight = 0
//        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 170, 0)
        tableView.separatorStyle = .none
        
    }


}

extension XYArticleDescribeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XYArticleDescribeController.cellIdenftifier)
        
        cell?.textLabel?.text = "\(indexPath.row)" + "行"
        return cell!
    }
}


