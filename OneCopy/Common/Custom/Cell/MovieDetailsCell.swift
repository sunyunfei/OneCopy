//
//  MovieDetailsCell.swift
//  OneCopy
//
//  Created by 孙云飞 on 2017/1/16.
//  Copyright © 2017年 DJY. All rights reserved.
//

import UIKit

class MovieDetailsCell: UITableViewCell {

    //图片
    var topImageView:UIImageView?
    //文字
    var comentLabel:UILabel?
    //数据
    var model:MovieDetailsModel?{
    
        didSet{
        
            p_loadData()
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //load UI
        topImageView = UIImageView.init(frame: CGRect.init(x: 8, y: 8, w: self.contentView.frame.size.width - 16, h:200))
        topImageView?.layer.shadowColor = UIColor.lightGray.cgColor
        topImageView?.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        topImageView?.layer.shadowOpacity = 0.8
        topImageView?.layer.shadowRadius = 1
        self.contentView.addSubview(topImageView!)
        //默认图片
        topImageView?.image = UIImage.init(named: "default")
        
        comentLabel = UILabel.init()
        comentLabel?.numberOfLines = 0
        comentLabel?.textColor = UIColor.lightGray
        comentLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(comentLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //数据加载
    func p_loadData(){
    
        let url = URL(string : (model?.image)!)
        topImageView?.kf.setImage(with: url)
        comentLabel?.text = model?.content as String?
        //计算高度
        let rect:CGRect = Tools.getTextRectSize(text: model!.content!, font: UIFont.systemFont(ofSize: 15), size: CGSize.init(width: UIScreen.main.bounds.size.width, height: CGFloat(MAXFLOAT)))
        comentLabel?.frame = CGRect.init(x: 0, y: (topImageView?.frame.origin.y)! + (topImageView?.frame.size.height)! + 5, w: rect.size.width, h: rect.size.height)
    }
    
    //返回单元格高度
    static func returnCellHeight(cellModel:MovieDetailsModel)->CGFloat{
    
        //计算高度
        let rect:CGRect = Tools.getTextRectSize(text: cellModel.content!, font: UIFont.systemFont(ofSize: 15), size: CGSize.init(width: UIScreen.main.bounds.size.width, height: CGFloat(MAXFLOAT)))
        
        return rect.size.height + 8 * 2 + 200;
    }

}
