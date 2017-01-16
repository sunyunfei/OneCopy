//
//  MovieHeaderView.swift
//  OneCopy
//
//  Created by 孙云飞 on 2017/1/16.
//  Copyright © 2017年 DJY. All rights reserved.
//

import UIKit

class MovieHeaderView: UIView {

    //UI
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    //数据
    var model:MovieDetailsModel?{
    
        didSet{
        
            p_dealModel()
        }
    }
    //构造方法
    static func createMovieHeaderView()-> MovieHeaderView{
    
        return Bundle.main.loadNibNamed("MovieHeaderView", owner: self, options: nil)?.last as! MovieHeaderView
    }
    
    override func awakeFromNib() {
        
        //来个阴影
        iconImage.layer.shadowColor = UIColor.lightGray.cgColor
        iconImage.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        iconImage.layer.shadowOpacity = 0.8
        iconImage.layer.shadowRadius = 1

    }
    
    //数据处理
    func p_dealModel(){
    
        if model != nil {
            let url = URL(string : (model?.icon)!)
            iconImage?.kf.setImage(with: url)
            nameLabel.text = model?.name
            timeLabel.text = "上映时间:" + (model?.time)!
            actorLabel.text = "主演:" + (model?.actor)!
            typeLabel.text = "类别:" + (model?.type)!
            commentLabel.text = model?.des
        }
    }
}
