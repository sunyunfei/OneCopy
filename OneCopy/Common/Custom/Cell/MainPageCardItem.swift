//
//  MainPageCardItem.swift
//  OneCopy
//
//  Created by Mac on 16/10/8.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit
import Kingfisher

class MainPageCardItem: UIView,UIScrollViewDelegate,UIGestureRecognizerDelegate {

    var model : MainPageCardModel!
    var cardView : UIView!
    var scrollView : UIScrollView!
    var scrollViewSpaceToToolView : CGFloat = 0.0
    
    var noteImageView : UIImageView!
    var noteLbl : UILabel!
    var zanImageView : UIImageView!
    var zanLbl : UILabel!
    var shareImageView : UIImageView!
    
    var cradHeightIsOverView : Bool = false //卡片高度是否超过view,若超过，滑动时计算toolview动画时使用的方式不一样，此处代码带待优化
    
    init(model: MainPageCardModel,frame : CGRect) {
        
        super.init(frame: frame)
        
        self.model = model
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        
        //滚动视图
        self.scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        self.scrollView.backgroundColor = UIColor.white
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.addSubview(self.scrollView)
        
        //整个背景
        let backgroundView : UIView = UIView.init(frame: (self.model.frameModel?.backgroundFrame)!)
        backgroundView.backgroundColor = UIColor.clear
        self.scrollView.addSubview(backgroundView)
        
        //卡片
        self.cardView = UIView.init(frame: (self.model.frameModel?.cardFrame)!)
        self.cardView.layer.cornerRadius = 6
        self.cardView.layer.shadowColor = UIColor.black.cgColor
        self.cardView.layer.shadowRadius = 2
        self.cardView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        self.cardView.layer.shadowOpacity = 0.23
        self.cardView.backgroundColor = UIColor.white
        backgroundView.addSubview(self.cardView)
        
        //图片
        let picView : UIImageView = UIImageView.init(frame: (self.model.frameModel?.picFrame)!)
        let url = URL(string : self.model.picUrl as! String)
        picView.contentMode = UIViewContentMode.scaleAspectFill
        picView.layer.masksToBounds = true
        picView.kf.setImage(with: url)
        let picTap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(MainPageCardItem.picClick))
        picView.isUserInteractionEnabled = true
        picView.addGestureRecognizer(picTap)
        self.cardView.addSubview(picView)
        
        //期号
        let volLable : UILabel = UILabel.init(frame: (self.model.frameModel?.volNumLblFrame)!)
        volLable.text = NSString.init(format: "VOL.%d", self.model.volNum) as String
        volLable.textColor = UIColor.lightGray
        volLable.font = UIFont.systemFont(ofSize: 10)
        volLable.textAlignment = NSTextAlignment.left
        self.cardView.addSubview(volLable)
        
        //作者
        let writerLable : UILabel = UILabel.init(frame: (self.model.frameModel?.writerLblFrame)!)
        writerLable.text = self.model.writerName as String?
        writerLable.font = UIFont.systemFont(ofSize: 10)
        writerLable.textColor = UIColor.lightGray
        writerLable.textAlignment = NSTextAlignment.right
        self.cardView.addSubview(writerLable)
        
        //文本
        let contentTextView : UITextView = UITextView.init(frame: (self.model.frameModel?.contentViewFrame)!)
        contentTextView.isUserInteractionEnabled = false
    
        let attStr : NSMutableAttributedString = NSMutableAttributedString.init(string: self.model.content as! String)
        //段落设置
        let style : NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        style.alignment = NSTextAlignment.justified
        style.lineSpacing = 10
        style.hyphenationFactor = 0.1
        style.lineBreakMode = NSLineBreakMode.byCharWrapping
        attStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: (self.model.content?.length)!))
        //字体设置
        let ats = [NSFontAttributeName : UIFont.systemFont(ofSize: 14)]
        attStr.addAttributes(ats, range: NSRange.init(location: 0, length: (self.model.content?.length)!))
        
        contentTextView.attributedText = attStr
        self.cardView.addSubview(contentTextView)
        
        //时间
        let timeLable : UILabel = UILabel.init(frame: (self.model.frameModel?.timeLblFrame)!)
        timeLable.text = self.model.writeTime as String?
        timeLable.font = UIFont.systemFont(ofSize: 12)
        timeLable.textColor = UIColor.lightGray
        timeLable.textAlignment = NSTextAlignment.right
        self.cardView.addSubview(timeLable)
        
        //卡片下方工具栏
        let toolViewHeight : CGFloat = 60.0
        
        if self.cardView.frame.maxY > scrollView.frame.size.height - 49 - 64
        {
            scrollView.contentSize = CGSize.init(width: 0, height:self.cardView.frame.maxY + 49 + 64 + toolViewHeight)
            
        }else {
            scrollView.contentSize = CGSize.init(width: 0, height:(self.model.frameModel?.cardFrame?.size.height)! + 150 + 49 + 64)
        }
        
        var toolViewY : CGFloat = 0.0
    
        //卡片高度 + 工具栏高度 < scrollView高度
        if (self.cardView.frame.maxY + toolViewHeight) <= scrollView.frame.size.height - 49 - 64 {
            
            toolViewY = scrollView.frame.size.height - toolViewHeight - 49 - 64
            
            self.scrollViewSpaceToToolView = self.frame.size.height - cardView.frame.maxY - toolViewHeight - 49 - 64
        }
        else {
            
            let overHeight = (self.cardView.frame.maxY + toolViewHeight) - (scrollView.frame.size.height - 49 - 64)
            
            toolViewY = (scrollView.frame.size.height - 49 - 64) + overHeight
            
            self.scrollViewSpaceToToolView = overHeight
            
            self.cradHeightIsOverView = true
        }
        
        //工具栏
        //小记
        self.noteImageView = UIImageView.init(frame: CGRect.init(x: 15, y: toolViewY + 20, width: 18, height: 21))
        self.noteImageView.image = UIImage.init(named: "xiaoji")
        self.noteImageView.contentMode = UIViewContentMode.scaleAspectFill
        self.addSubview(self.noteImageView)
        
        self.noteLbl = UILabel.init(frame: CGRect.init(x: self.noteImageView.frame.maxX + 8, y: toolViewY + 19, width: 38, height: 21))
        self.noteLbl.font = UIFont.systemFont(ofSize: 12)
        self.noteLbl.textColor = UIColor.gray
        self.noteLbl.text = "小 记"
        self.addSubview(self.noteLbl)
        
        //分享
        self.shareImageView = UIImageView.init(frame: CGRect.init(x: self.frame.size.width - 15 - 20, y: toolViewY + 20, width: 20, height: 20))
        self.shareImageView.image = UIImage.init(named: "share_n")
        self.shareImageView.contentMode = UIViewContentMode.scaleAspectFill
        self.addSubview(self.shareImageView)
        
        //赞
        self.zanLbl = UILabel.init(frame: CGRect.init(x: self.shareImageView.frame.origin.x - 16 - 57, y: toolViewY + 20, width: 57, height: 21))
        self.zanLbl.font = UIFont.systemFont(ofSize: 12)
        self.zanLbl.textColor = UIColor.gray
        self.zanLbl.text = String.init(format: "%d", self.model.zanNum)
        self.zanLbl.textAlignment = NSTextAlignment.center
        self.addSubview(self.zanLbl)
        
        self.zanImageView = UIImageView.init(frame: CGRect.init(x: self.zanLbl.frame.origin.x - 22, y: toolViewY + 20, width: 22, height: 20))
        self.zanImageView.isUserInteractionEnabled = true
        self.zanImageView.image = UIImage.init(named: "xin")
        self.zanImageView.contentMode = UIViewContentMode.scaleAspectFill
        self.addSubview(self.zanImageView)
        
        let zanTap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:#selector(MainPageCardItem.zanClick))
        self.zanImageView.addGestureRecognizer(zanTap)
    
        self.setZan(model: self.model)
        
        //监听contentOffset ,可以用scrollview代理代替
        self.scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    func setZan(model : MainPageCardModel) -> Void {
        
        self.zanLbl.text = String.init(format: "%d", model.zanNum)
        
        if self.model?.isZan == true {
            
            self.zanImageView.image = UIImage.init(named:"xin2")
            
        }else {
            
            self.zanImageView.image = UIImage.init(named:"xin")
        }
    }
    
    func zanClick() -> Void {
        
        if self.model?.isZan == true {
            
            self.model?.isZan = false
            self.model?.zanNum -= 1
            
        }else {
            
            self.model?.isZan = true
            self.model?.zanNum += 1
        }
        
        self.setZan(model: self.model!)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "contentOffset" {
            
            let resultPoint = change?[NSKeyValueChangeKey.newKey] as! NSValue
            let point : CGPoint = resultPoint.cgPointValue //contentOffSet

            if self.cradHeightIsOverView == true {
                
                //滑动距离,如果当前滑动距离是向上滑动的，且>self.scrollViewSpaceToToolView + 60，那么让toolView移动到完全显示
                if point.y >= self.scrollViewSpaceToToolView + 60 {
                    
//                    self.toolView.transform = CGAffineTransform.init(translationX: 0, y:-(self.scrollViewSpaceToToolView + 60))
                    
                    self.noteImageView.transform = CGAffineTransform.init(translationX: 0, y:-(self.scrollViewSpaceToToolView + 60))
                    self.noteLbl.transform = CGAffineTransform.init(translationX: 0, y:-(self.scrollViewSpaceToToolView + 60))
                    self.zanLbl.transform = CGAffineTransform.init(translationX: 0, y:-(self.scrollViewSpaceToToolView + 60))
                    self.zanImageView.transform = CGAffineTransform.init(translationX: 0, y:-(self.scrollViewSpaceToToolView + 60))
                    self.shareImageView.transform = CGAffineTransform.init(translationX: 0, y:-(self.scrollViewSpaceToToolView + 60))
                    
                }
                else if point.y >= 0 && point.y < self.scrollViewSpaceToToolView + 60 {
                    //如果是向上滑动，但没有超出完全显示距离,那么让toolView向上移动相应距离,如果超出了，则到最大距离
                    
                    var targetY : CGFloat = point.y + 60
                    
                    if targetY > (self.scrollViewSpaceToToolView + 60) {
                        
                        targetY = self.scrollViewSpaceToToolView + 60
                    }
                    
                    self.noteImageView.transform = CGAffineTransform.init(translationX: 0, y:-targetY)
                    self.noteLbl.transform = CGAffineTransform.init(translationX: 0, y:-targetY)
                    self.zanLbl.transform = CGAffineTransform.init(translationX: 0, y:-targetY)
                    self.zanImageView.transform = CGAffineTransform.init(translationX: 0, y:-targetY)
                    self.shareImageView.transform = CGAffineTransform.init(translationX: 0, y:-targetY)
                    
//                    self.toolView.transform = CGAffineTransform.init(translationX: 0, y:-targetY)
                }
                else if point.y <= 0{
                    
                    //原位置且往下滑动了
                    self.noteImageView.transform = CGAffineTransform.init(translationX: 0, y:0)
                    self.noteLbl.transform = CGAffineTransform.init(translationX: 0, y:0)
                    self.zanLbl.transform = CGAffineTransform.init(translationX: 0, y:0)
                    self.zanImageView.transform = CGAffineTransform.init(translationX: 0, y:0)
                    self.shareImageView.transform = CGAffineTransform.init(translationX: 0, y:0)
                    
//                    self.toolView.transform = CGAffineTransform.init(translationX: 0, y:0)
                }
                
            }
            else {
                
                let padding : CGFloat = 3
                
                if point.y - padding <= -self.scrollViewSpaceToToolView {
    
                    var targetY : CGFloat = -(point.y - padding) - self.scrollViewSpaceToToolView
    
                    if targetY < 0 {
                        
                        targetY = 0
                    }
                    
                    self.noteImageView.transform = CGAffineTransform.init(translationX: 0, y:targetY)
                    self.noteLbl.transform = CGAffineTransform.init(translationX: 0, y:targetY)
                    self.zanLbl.transform = CGAffineTransform.init(translationX: 0, y:targetY)
                    self.zanImageView.transform = CGAffineTransform.init(translationX: 0, y:targetY)
                    self.shareImageView.transform = CGAffineTransform.init(translationX: 0, y:targetY)
                }
            }
        }
    }
    
    //图片点击
    func picClick(tap : UIGestureRecognizer) -> Void {
        
        let browser : ZQImageBrowser = ZQImageBrowser.init(frame: UIScreen.main.bounds)
        
        let model : ZQImageBrowserModel = ZQImageBrowserModel.init()
        model.exitAnimationMode = ZQImageBrowserAnimationMode(rawValue: 0)!
        let imageView : UIImageView = tap.view as! UIImageView
        model.sourceImage = imageView.image
        model.thumImageView = imageView
        browser.selectedIndex = 0;
        browser.models = NSMutableArray.init(object: model)
        browser.show()
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "contentOffset", context:nil);
    }
}
