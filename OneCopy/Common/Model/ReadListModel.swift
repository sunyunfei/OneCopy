//
//  ReadListModel.swift
//  OneCopy
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class ReadListFrameModel: BaseModel {
    
    var titleLblFrame       : CGRect?
    var writerLblFrame      : CGRect?
    var contentViewFrame    : CGRect?
    var typeLblFrame        : CGRect?
    var lineFrame           : CGRect?
}

class ReadModel: BaseModel {
    
    var frameModel : ReadListFrameModel?
    
    var title    : NSString?
    var writer   : NSString?
    var content  : NSString?
    var type     : NSString?

}

class ReadListModel: BaseModel {
    
    let topMargin       : CGFloat = 15
    let insidePadding   : CGFloat = 10
    let outsidePadding  : CGFloat = 10
    let contentPadding  : CGFloat = 10
    let bottomMargin    : CGFloat = 15
    
    let titleFont       : CGFloat = 17.5
    let contentFont     : CGFloat = 13
    let typeFont        : CGFloat = 10
    let lineSpace       : CGFloat = 10
    
    var listCardFrame   : CGRect?
    
    //保存了每一页的文章
    var readList        : [ReadModel]?
    
    //每一页的每一个文章在列表中的frame,调用calLayout后
    var readListFrames : [ReadListFrameModel]?
    
    func calLayout() -> Void {
        
        self.readListFrames = Array.init()
        
        let typeW : CGFloat = 40
        let cardW : CGFloat = APPWINDOWWIDTH - outsidePadding * 2
        let titleW : CGFloat = cardW - insidePadding * 2 - typeW
        
        var totolHeight : CGFloat = 0
        for model : ReadModel in self.readList! {
            
            let frameModel : ReadListFrameModel = ReadListFrameModel.init()
        
            //类型lbl
            frameModel.typeLblFrame = CGRect.init(x: cardW - outsidePadding - typeW, y: topMargin + totolHeight , width: typeW, height: 20)
            
            //算title的size ,宽是确定的
            let titleSize = Tools.getTextRectSize(text: model.title!, font: UIFont.systemFont(ofSize: titleFont), size: CGSize.init(width: titleW, height:CGFloat(MAXFLOAT)))
            frameModel.titleLblFrame = CGRect.init(x: insidePadding, y: topMargin + totolHeight, width: cardW - insidePadding * 2 - (frameModel.typeLblFrame?.width)! - insidePadding, height:titleSize.height)
            
            //作者
            frameModel.writerLblFrame = CGRect.init(x: insidePadding, y: (frameModel.titleLblFrame?.maxY)! + contentPadding , width: 250, height: UIFont.systemFont(ofSize: contentFont).lineHeight)
            
            //内容 
            //原文本size
            let contentOriTextRect = Tools.getTextRectSize(text: model.content!, font: UIFont.systemFont(ofSize: contentFont), size: CGSize.init(width: cardW - insidePadding * 2, height:CGFloat(MAXFLOAT)))
            //算高度
            //1.算大概有多少行
            let rowNum : CGFloat = contentOriTextRect.height / (UIFont.systemFont(ofSize: contentFont).lineHeight)
            //2.原高度 ＋ 总行间距 ＋ 误差
            let contentHeight = contentOriTextRect.height + (rowNum - 1) * lineSpace + 10.0
            
            frameModel.contentViewFrame = CGRect.init(x:0, y: (frameModel.writerLblFrame?.maxY)! + contentPadding , width: cardW, height: contentHeight)
            
            frameModel.lineFrame = CGRect.init(x: insidePadding, y: (frameModel.contentViewFrame?.maxY)! + bottomMargin , width: cardW - insidePadding * 2, height: 1)
            
            self.readListFrames?.append(frameModel)
            
            totolHeight = (frameModel.lineFrame?.maxY)!
        }
        
        self.listCardFrame = CGRect.init(x: outsidePadding, y: outsidePadding, width: APPWINDOWWIDTH - outsidePadding * 2, height: totolHeight)
        
    }
    
}
