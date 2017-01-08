//
//  MainPageVC.swift
//  OneCopy
//
//  Created by Mac on 16/10/8.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class MainPageVC: BaseViewController {

    var scrollView : UIScrollView!
    var datas      : [MainPageCardModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        
        self.getDatas()
        
        self.setupViews()
    }
    
    func setupViews() -> Void {
        
        self.scrollView = UIScrollView.init(frame: self.view.bounds)
        self.scrollView.isPagingEnabled = true
        
        self.view.addSubview(self.scrollView!)
        
        for i in 0  ..< self.datas.count  {
            
            let item : MainPageCardItem = MainPageCardItem.init(model: self.datas[i], frame: CGRect.init(x: CGFloat.init(i) * self.view.bounds.size.width, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height));
            self.scrollView?.addSubview(item)
        }

        self.scrollView.contentSize = CGSize.init(width: CGFloat.init(self.datas.count) * self.view.bounds.size.width, height: 0)
    }
    
    //获取数据
    func getDatas() -> Void {
        
        self.datas = Array.init()
        
        let model_1 : MainPageCardModel = MainPageCardModel.init()
        model_1.volNum = 1;
        model_1.writerName = "老董小号1 作品"
        model_1.content = "越在乎，越畏缩，每一次的欲言又止，都藏一万句短促的情诗。 by 姬霄"
        model_1.writeTime = "Mon 10 Oct.2016"
        model_1.zanNum = 6
        model_1.picUrl = "http://image2081-c.poco.cn/mypoco/myphoto/20110828/15/9683049201108281542173333327427397_006_640.jpg"
        model_1.layout()
        model_1.isZan = true
        self.datas.append(model_1)
        
        let model_2 : MainPageCardModel = MainPageCardModel.init()
        model_2.volNum = 2;
        model_2.writerName = "老董小号2 作品"
        model_2.content = "当有人逼迫你去突破自己，你要感恩他。他是你生命中的贵人,也许你会因此而改变和蜕变。当没有人逼迫你，请自己逼迫自己，因为真正的改变是自己想改变。蜕变的过程是很痛苦的，但每一次的蜕变都会有成长的惊喜。 by 巴菲特"
        model_2.picUrl = "http://image18-c.poco.cn/mypoco/myphoto/20160626/13/5180266120160626132343019_640.jpg?680x1020_120"
        model_2.writeTime = "Mon 10 Oct.2016"
        model_2.zanNum = 66
        model_2.layout()
        model_2.isZan = false
        self.datas.append(model_2)
        
        let model_3 : MainPageCardModel = MainPageCardModel.init()
        model_3.volNum = 3;
        model_3.writerName = "老董小号3 作品"
        model_3.content = "井蛙不可以语于海者，拘于虚也；夏虫不可以语于冰者，笃于时也；曲士不可以语于道者，束于教也。"
        model_3.picUrl = "http://image16-c.poco.cn/mypoco/myphoto/20140628/09/3850395920140628095839077_640.jpg?821x1024_120"
        model_3.writeTime = "Mon 11 Oct.2016"
        model_3.zanNum = 666
        model_3.layout()
        model_3.isZan = true
        self.datas.append(model_3)
        
        let model_4 : MainPageCardModel = MainPageCardModel.init()
        model_4.volNum = 4;
        model_4.writerName = "老董小号4 作品"
        model_4.content = "懒惰是很奇怪的东西，它使你以为那是安逸，是休息，是福气；但实际上它所给你的是无聊，是倦怠，是消沉； 它剥夺你对前途的希望，割断你和别人之间的友情，使你心胸日渐狭窄，对人生也越来越怀疑。"
        model_4.picUrl = "http://image17-c.poco.cn/mypoco/myphoto/20160229/18/518026612016022918500901_640.jpg?680x1020_120"
        model_4.writeTime = "Mon 12 Oct.2016"
        model_4.zanNum = 6666
        model_4.layout()
        model_4.isZan = false
        self.datas.append(model_4)
        
        let model_5 : MainPageCardModel = MainPageCardModel.init()
        model_5.volNum = 5;
        model_5.writerName = "老董小号5 作品"
        model_5.content = "希望是附丽于存在的，有存在，便有希望，有希望，便是光明。"
        model_5.picUrl = "http://image18-c.poco.cn/mypoco/myphoto/20160709/22/5615097720160709222319035_640.jpg?850x850_120"
        model_5.writeTime = "Mon 13 Oct.2016"
        model_5.zanNum = 66666
        model_5.layout()
        model_5.isZan = true
        self.datas.append(model_5)
    }

    
}
