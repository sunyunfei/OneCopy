//
//  MovieVC.swift
//  OneCopy
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class MovieVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView!
    var datas : [MovieListModel]!
    
    static var movieListReuseID : String = "MovieListReuseID"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "电影"
        
        self.datas = Array.init()
        
        self.getData()
        
        self.setupView()
    }
    
    func setupView() -> Void {
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64 - 49))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView.init()
        self.view.addSubview(self.tableView)
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { 
            
        })
        
        self.tableView.mj_footer.endRefreshingWithNoMoreData()
    }
    
    func getData() -> Void {
        
        //网络请求
        HttpManager.movieGet { dataArray in
            
            //遍历数组
            for dic:Dictionary<String,AnyObject> in dataArray{
            
                let model : MovieListModel = MovieListModel.init(dic: dic)
                self.datas.append(model)
            }
            //刷新表
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.datas.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : MovieListCell? = tableView.dequeueReusableCell(withIdentifier: MovieVC.movieListReuseID) as! MovieListCell?
        
        if cell == nil {
            
            cell = Bundle.main.loadNibNamed("MovieListCell", owner: nil, options: nil)?.first as! MovieListCell?
        }
    
        cell?.imgView.image = UIImage.init(named: "default")
        //网络图片显示
        let url = URL(string : self.datas[indexPath.row].image!)
        cell?.imgView?.kf.setImage(with: url)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //取得对应的数据
        let model : MovieListModel = datas[indexPath.row];
        //跳转界面
        let movieDetailsVC = MovieDetailsVC()
        movieDetailsVC.movieId = model.movieId
        //让tabbar消失
        self.hidesBottomBarWhenPushed = true
        self.pushVC(movieDetailsVC)
        //让tabbr出现
        self.hidesBottomBarWhenPushed = false
    }
    
}



/*
 let model_1 : MovieListModel = MovieListModel.init()
 model_1.image = UIImage.init(named: "M_1")
 self.datas.append(model_1)
 
 let model_2 : MovieListModel = MovieListModel.init()
 model_2.image = UIImage.init(named: "M_2")
 self.datas.append(model_2)
 
 let model_3 : MovieListModel = MovieListModel.init()
 model_3.image = UIImage.init(named: "M_3")
 self.datas.append(model_3)
 
 let model_4 : MovieListModel = MovieListModel.init()
 model_4.image = UIImage.init(named: "M_4")
 self.datas.append(model_4)
 
 let model_5 : MovieListModel = MovieListModel.init()
 model_5.image = UIImage.init(named: "M_5")
 self.datas.append(model_5)
 
 let model_6 : MovieListModel = MovieListModel.init()
 model_6.image = UIImage.init(named: "M_6")
 self.datas.append(model_6)*/
