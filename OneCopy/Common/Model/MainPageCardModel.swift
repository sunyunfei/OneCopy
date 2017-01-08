//
//  MainPageCardModel.swift
//  OneCopy
//
//  Created by Mac on 16/10/8.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class MainPageCardFrameModel: AnyObject {
    
    var backgroundFrame  : CGRect?
    var cardFrame        : CGRect?
    var picFrame         : CGRect?
    var volNumLblFrame   : CGRect?
    var writerLblFrame   : CGRect?
    var contentViewFrame : CGRect?
    var timeLblFrame     : CGRect?
    
    var toolbarFrame     : CGRect?
    var noteBtnFrame     : CGRect?
    var zanBtnFrame      : CGRect?
    var shareBtnFrame    : CGRect?
}

class MainPageCardModel: BaseModel {

    let backgroundFixH    : CGFloat = 60.0
    let contentTextFont   : CGFloat = 14.0
    let subInfoTextFont   : CGFloat = 10.0
    let cardOutsideMargin : CGFloat = 15.0
    let cardInsideMargin  : CGFloat = 10.0
    let contentPadding    : CGFloat = 5.0
    let contentLineSpacing: CGFloat = 10.0
    let contentTopMargin  : CGFloat = 12.0
    let timeLablePadding  : CGFloat = 15.0
    
    var frameModel  : MainPageCardFrameModel?
    var picUrl      : NSString?
    var volNum      : Int = 0
    var writerName  : NSString?
    var content     : NSString?
    var writeTime   : NSString?
    var zanNum      : Int = 0
    var isZan       : Bool = false
    
    func layout() -> Void {
        
        self.frameModel = MainPageCardFrameModel.init()
        
        self.frameModel?.backgroundFrame = CGRect.init(x: 0, y: 0, width: APPWINDOWWIDTH, height: APPWINDOWHEIGHT)
        
        //图片 frame
        let picW : CGFloat = APPWINDOWWIDTH - cardOutsideMargin * 2 - cardInsideMargin * 2

        self.frameModel?.picFrame = CGRect.init(x: cardInsideMargin, y: cardInsideMargin, width: picW, height: picW * 0.75)
        
        //vol frame
        let volNumTextRect = Tools.getTextRectSize(text: NSString.init(format: "VOL.%d", self.volNum), font: UIFont.systemFont(ofSize: subInfoTextFont), size: CGSize.init(width: CGFloat(MAXFLOAT), height: UIFont.systemFont(ofSize: subInfoTextFont).lineHeight))
        
        self.frameModel?.volNumLblFrame = CGRect.init(x: cardInsideMargin, y: (self.frameModel?.picFrame?.maxY)! + cardInsideMargin, width:volNumTextRect.width, height: volNumTextRect.height)
        
        //作者 frame
        let cardW : CGFloat = APPWINDOWWIDTH - cardOutsideMargin * 2
        
        let writerTextRect = Tools.getTextRectSize(text: NSString.init(format: "%@ 作品", self.writerName!), font: UIFont.systemFont(ofSize: subInfoTextFont), size: CGSize.init(width: CGFloat(MAXFLOAT), height: UIFont.systemFont(ofSize: subInfoTextFont).lineHeight))
        
        self.frameModel?.writerLblFrame = CGRect.init(x: cardW - cardInsideMargin - writerTextRect.width, y: (self.frameModel?.volNumLblFrame?.origin.y)!, width: writerTextRect.width, height: writerTextRect.height)
        
        //内容 frame
        //原文本size
        let contentOriTextRect = Tools.getTextRectSize(text: self.content!, font: UIFont.systemFont(ofSize: contentTextFont), size: CGSize.init(width: cardW - contentPadding * 2, height:CGFloat(MAXFLOAT)))
        
        //算高度
        //1.算大概有多少行
        let rowNum : CGFloat = contentOriTextRect.height / (UIFont.systemFont(ofSize: contentTextFont).lineHeight)
        //2.原高度 ＋ 总行间距 ＋ 误差
        let contentHeight = contentOriTextRect.height + (rowNum - 1) * contentLineSpacing + 10.0
        
        self.frameModel?.contentViewFrame = CGRect.init(x: contentPadding, y: (self.frameModel?.writerLblFrame?.maxY)! + contentTopMargin, width: cardW - contentPadding * 2, height: contentHeight)
        
        //时间 frame 
        let timeTextRect = Tools.getTextRectSize(text: " Mon 10 Oct.2016 ", font: UIFont.systemFont(ofSize: 12), size: CGSize.init(width: CGFloat(MAXFLOAT), height: UIFont.systemFont(ofSize: 12).lineHeight))
        
        self.frameModel?.timeLblFrame = CGRect.init(x: cardW - cardInsideMargin - timeTextRect.width, y: (self.frameModel?.contentViewFrame?.maxY)! + timeLablePadding, width: timeTextRect.width, height: timeTextRect.height)
        
        //card frame
        self.frameModel?.cardFrame = CGRect.init(x: cardOutsideMargin, y: cardOutsideMargin, width: cardW, height: (self.frameModel?.timeLblFrame?.maxY)! + cardInsideMargin)
        
        //background frame
        self.frameModel?.backgroundFrame = CGRect.init(x: 0, y: 0, width: APPWINDOWWIDTH, height: (self.frameModel?.cardFrame?.size.height)!)
    }
    
}


