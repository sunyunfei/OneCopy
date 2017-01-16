//
//  MovieDetailsVC.swift
//  OneCopy
//
//  Created by 孙云飞 on 2017/1/16.
//  Copyright © 2017年 DJY. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //传递过来的id
    var movieId:Int?{
    
        didSet{
        
            self.p_getData()
        }
    }
    //数据
    var detailsModel:MovieDetailsModel?
    //数据表
    var tableView:UITableView?
    //表头
    var headerView:MovieHeaderView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //加载表
    func p_loadTableView(){
    
        tableView = UITableView.init(frame: self.view.bounds)
        tableView?.delegate = self;
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        self.view.addSubview(tableView!)
        p_loadHeaderView()
    }
    //加载表头
    func p_loadHeaderView(){

        headerView = MovieHeaderView.createMovieHeaderView()
        headerView?.frame = CGRect.init(x: 0, y: 0, w: self.view.frame.size.width, h: 300)
        headerView?.model = self.detailsModel
        tableView?.tableHeaderView = headerView
    
    }
    
    //数据请求
    func p_getData(){
    
        HttpManager.movieDetailsGet(movieId: movieId!, success: { dic in
            
            //数据处理
            self.detailsModel = MovieDetailsModel.init(dic: dic)
            DispatchQueue.main.async {
               
                self.p_loadTableView()
            }
        })
    }
    
    //代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if detailsModel != nil {
            return 1;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MovieDetailsCell = MovieDetailsCell.init(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        cell.model = detailsModel
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return MovieDetailsCell.returnCellHeight(cellModel:detailsModel!)
    }

}
