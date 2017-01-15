//
//  ReadVC.swift
//  OneCopy
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class ReadVC: BaseViewController {

    var bannerView : NJBannerView!
    var datas      : [ReadListModel]!
    var scrollView : UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "阅读"
        
        self.datas = Array.init()
        
        self.getListDatas()
        
    }
    
    func setupView() -> Void {
        
        //bannerview
        self.bannerView = NJBannerView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 150))
        self.getBannerDatas()
        self.view.addSubview(self.bannerView)
        
        //scrollview
        self.scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 150, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64 - 49 - 49))
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        
        for i in 0..<self.datas.count {
            
            let item = ReadListCardItem.init(model: self.datas[i], frame: CGRect.init(x: self.scrollView.bounds.width * CGFloat.init(i), y: 0, w: self.scrollView.bounds.width, h: self.scrollView.bounds.height))
            self.scrollView.addSubview(item)
        }
        
        self.scrollView.contentSize = CGSize.init(width: CGFloat.init(self.datas.count) * self.view.bounds.size.width, height: 0)
        
        self.view.addSubview(self.scrollView)
    }
    
    func getBannerDatas() -> Void {
        
        let datas : NSMutableArray = NSMutableArray.init()
        let tempDict1 : Dictionary = ["img":"b_1","link":""]
        let tempDict2 : Dictionary = ["img":"b_2","link":""]
        let tempDict3 : Dictionary = ["img":"b_3","link":""]
        let tempDict4 : Dictionary = ["img":"b_4","link":""]
        datas.add(tempDict1)
        datas.add(tempDict2)
        datas.add(tempDict3)
        datas.add(tempDict4)
        self.bannerView.datas = datas
    }
    
    func getListDatas() -> Void {
        
        let list_1 : ReadListModel = ReadListModel.init()
        list_1.readList = Array.init()
        
        //网络请求
        HttpManager.readConmentGet { dataArray in
            
            //遍历数组
            for dic:Dictionary<String,AnyObject> in dataArray{
            
                let model : ReadModel = ReadModel.init()
                model.title = dic["title"] as! NSString?
                model.writer = dic["writer"] as! NSString?
                model.content = dic["content"] as! NSString?
                model.type = dic["type"] as! NSString?
                list_1.readList?.append(model)
            }
            
            list_1.calLayout()
            
            self.datas.append(list_1)
            self.datas.append(list_1)
            DispatchQueue.main.async {
                
               self.setupView()
            }
        }
        
        
    }
}




//        let model_1 : ReadModel = ReadModel.init()
//        model_1.title = "云想衣裳"
//        model_1.writer = "吴浩然"
//        model_1.content = "岂止衣裳不知道放哪了。你现在年轻，不知道的还多着呢。"
//        model_1.type = "短篇"
//        list_1.readList?.append(model_1)
//
//        let model_2 : ReadModel = ReadModel.init()
//        model_2.title = "玩家 第七话"
//        model_2.writer = "夜X"
//        model_2.content = "愤怒是治疗恐惧的良方，而它自身的副作用大小因人而异。陆仁甲克服它只用了大概二十秒的时间"
//        model_2.type = "连载"
//        list_1.readList?.append(model_2)
//
//        let model_3 : ReadModel = ReadModel.init()
//        model_3.title = "人与人之间的信任到底有多脆弱"
//        model_3.writer = "@周宏翔 答潘大曼"
//        model_3.content = "有时候并非我们真正感到孤独，而是我们太敏感，太恐惧，太害怕受伤，才会让自己孤独。"
//        model_3.type = "问答"
//        list_1.readList?.append(model_3)
