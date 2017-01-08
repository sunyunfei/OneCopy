//
//  ReadListCardItem.swift
//  OneCopy
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class ReadListCardItem: UIView {

    var model : ReadListModel?
    
    var scrollView  : UIScrollView!
    var cardView    : UIView!
    
    init(model: ReadListModel,frame : CGRect) {
        
        super.init(frame: frame)
        
        self.model = model
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        
        self.scrollView = UIScrollView.init()
        self.scrollView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.scrollView.contentSize = CGSize.init(width: 0, height: (self.model?.listCardFrame?.height)! + (self.model?.outsidePadding)! * 2)
        self.scrollView.showsVerticalScrollIndicator = false
        self.addSubview(self.scrollView)
        
        self.cardView = UIView.init(frame: (self.model?.listCardFrame)!)
        self.cardView.layer.cornerRadius = 6
        self.cardView.layer.shadowColor = UIColor.black.cgColor
        self.cardView.layer.shadowRadius = 2
        self.cardView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        self.cardView.layer.shadowOpacity = 0.4
        self.cardView.backgroundColor = UIColor.white
        self.scrollView.addSubview(self.cardView)
        
        for i in 0 ..< (self.model?.readListFrames?.count)! {
            
            let dataModel  : ReadModel          = (self.model?.readList![i])!
            let frameModel : ReadListFrameModel = (self.model?.readListFrames![i])!
            
            let titleLbl : UILabel = UILabel.init(frame: frameModel.titleLblFrame!)
            titleLbl.font = UIFont.systemFont(ofSize: (self.model?.titleFont)!)
            titleLbl.numberOfLines = 0
            titleLbl.text = dataModel.title as String?
            self.cardView.addSubview(titleLbl)
            
            let writerLbl : UILabel = UILabel.init(frame: frameModel.writerLblFrame!)
            writerLbl.font = UIFont.systemFont(ofSize: (self.model?.contentFont)!)
            writerLbl.textColor = UIColor.gray
            writerLbl.text = dataModel.writer as String?
            self.cardView.addSubview(writerLbl)
            
            //类型
            let typeLbl : UILabel = UILabel.init(frame: frameModel.typeLblFrame!)
            typeLbl.layer.cornerRadius = 4
            typeLbl.layer.borderWidth = 0.5
            typeLbl.textAlignment = NSTextAlignment.center
            typeLbl.font = UIFont.systemFont(ofSize: (self.model?.typeFont)!)
            typeLbl.layer.borderColor = UIColor.init(hexString: "8EBCFF")?.cgColor
            typeLbl.textColor = UIColor.init(hexString: "8EBCFF")
            typeLbl.text = dataModel.type as String?
            self.cardView.addSubview(typeLbl)
            
            //内容
            let contentTextView : UITextView = UITextView.init(frame: frameModel.contentViewFrame!)
            contentTextView.isUserInteractionEnabled = false
            contentTextView.textContainerInset = UIEdgeInsetsMake(0, 5, 0, 5)
            
            let attStr : NSMutableAttributedString = NSMutableAttributedString.init(string: dataModel.content as! String)
            //段落设置
            let style : NSMutableParagraphStyle = NSMutableParagraphStyle.init()
            style.alignment = NSTextAlignment.justified
            style.lineSpacing = (self.model?.lineSpace)!
            style.hyphenationFactor = 0.1
            style.lineBreakMode = NSLineBreakMode.byCharWrapping
            attStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: (dataModel.content?.length)!))
            //字体设置
            let ats_font = [NSFontAttributeName : UIFont.systemFont(ofSize: (self.model?.contentFont)!)]
            let ats_color = [NSForegroundColorAttributeName : UIColor.gray]
            attStr.addAttributes(ats_font, range: NSRange.init(location: 0, length: (dataModel.content?.length)!))
            attStr.addAttributes(ats_color, range: NSRange.init(location: 0, length: (dataModel.content?.length)!))
            
            contentTextView.attributedText = attStr
            self.cardView.addSubview(contentTextView)
            
            //分割线
            let lineView : UIView = UIView.init(frame: frameModel.lineFrame!)
            lineView.backgroundColor = UIColor.groupTableViewBackground
            
            if i == (self.model?.readList?.count)! - 1 {
                
                break
            }
            
            self.cardView.addSubview(lineView)
        }
        
    }
    
}
