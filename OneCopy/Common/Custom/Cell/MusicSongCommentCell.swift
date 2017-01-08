//
//  MusicSongCommentCell.swift
//  OneCopy
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

protocol MusicSongCommentCellDelegate {
    
    func musicSongCommentCellShowAllContent(cell : MusicSongCommentCell) -> Void
}

class MusicSongCommentCell: UITableViewCell {

    var model : MusicCommentModel?
    var headerImgView : UIImageView?
    var nameLbl : UILabel?
    var timeLbl : UILabel?
    var zanLbl : UILabel?
    var zanImgView : UIImageView?
    
    var replyView : UIView?
    var replyNameLbl : UILabel?
    var replyContentTextView : UITextView?
    
    var contentTextView : UITextView?
    
    var bottomSepView : UIView?
    
    var zhankaiLbl : UILabel?
    
    var delegate : MusicSongCommentCellDelegate?
    
    init(model: MusicCommentModel) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        
        self.model = model
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        //头像
        self.headerImgView = UIImageView.init(frame: (self.model?.frameModel?.headerImageFrame)!)
        self.headerImgView?.layer.cornerRadius = (self.model?.frameModel?.headerImageFrame?.width)!/2
        self.headerImgView?.layer.masksToBounds = true
        self.headerImgView?.contentMode = UIViewContentMode.scaleAspectFill
        self.headerImgView?.image = UIImage.init(named: "header")
        self.contentView.addSubview(self.headerImgView!)
        
        self.nameLbl = UILabel.init(frame: (self.model?.frameModel?.nameLblFrame)!)
        self.nameLbl?.font = UIFont.systemFont(ofSize: (self.model?.nameFont)!)
        self.nameLbl?.textColor = UIColor.init(hexString: "8EBCFF")
        self.nameLbl?.text = self.model?.commentUserName
        self.contentView.addSubview(self.nameLbl!)
        
        self.timeLbl = UILabel.init(frame: (self.model?.frameModel?.timeLblFrame)!)
        self.timeLbl?.font = UIFont.systemFont(ofSize: (self.model?.timeFont)!)
        self.timeLbl?.textColor = UIColor.gray
        self.timeLbl?.text = self.model?.commentTime
        self.contentView.addSubview(self.timeLbl!)
        
        self.zanLbl = UILabel.init(frame: (self.model?.frameModel?.zanNumFrame)!)
        self.zanLbl?.font = UIFont.systemFont(ofSize: (self.model?.zanNumFont)!)
        self.zanLbl?.text = String.init(format: "%d", (self.model?.zanNum)!)
        self.zanLbl?.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.zanLbl!)
       
        self.zanImgView = UIImageView.init(frame: (self.model?.frameModel?.zanImageFrame)!)
        self.zanImgView?.contentMode = UIViewContentMode.scaleAspectFill
        self.zanImgView?.image = UIImage.init(named: "zan_n")
        self.contentView.addSubview(self.zanImgView!)
        
        if self.model?.haveReply == true {
            
            self.replyView = UIView.init(frame: (self.model?.frameModel?.replyFrame)!)
            self.replyView?.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            self.replyView?.layer.borderWidth = 1
            self.replyView?.layer.cornerRadius = 5
            self.contentView.addSubview(self.replyView!)
            
            self.replyNameLbl = UILabel.init(frame: (self.model?.frameModel?.replyLblFrame)!)
            self.replyNameLbl?.font = UIFont.systemFont(ofSize: (self.model?.replyNameFont)!)
            self.replyNameLbl?.textColor = UIColor.darkGray
            self.replyNameLbl?.text = self.model?.replyName
            self.replyView?.addSubview(self.replyNameLbl!)
            
            self.replyContentTextView = UITextView.init(frame: (self.model?.frameModel?.replyContentFrame)!)
            self.replyContentTextView?.isUserInteractionEnabled = false
            
            let attStr : NSMutableAttributedString = NSMutableAttributedString.init(string: self.model!.replyContent! as String)
            //段落设置
            let style : NSMutableParagraphStyle = NSMutableParagraphStyle.init()
            style.alignment = NSTextAlignment.justified
            style.lineSpacing = (self.model?.lineSpace)!
            style.hyphenationFactor = 0.1
            style.lineBreakMode = NSLineBreakMode.byCharWrapping
            attStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: (self.model?.replyContent?.length)!))
            //字体设置
            let ats_font = [NSFontAttributeName : UIFont.systemFont(ofSize: (self.model?.replyContentFont)!)]
            let ats_color = [NSForegroundColorAttributeName : UIColor.gray]
            attStr.addAttributes(ats_font, range: NSRange.init(location: 0, length: (self.model?.replyContent?.length)!))
            attStr.addAttributes(ats_color, range: NSRange.init(location: 0, length: (self.model?.replyContent?.length)!))
            self.replyContentTextView?.attributedText = attStr
            self.replyView?.addSubview(replyContentTextView!)
        
        }
        
        if (self.model?.isShowAll)! {
            
            self.contentTextView = UITextView.init(frame: (self.model?.frameModel?.allContentFrame)!)
            
            self.bottomSepView = UIView.init(x: 0, y: (self.model?.frameModel?.allCommentFrame?.height)! - 10, w: APPWINDOWWIDTH, h: 10)
            
            
        }else {
            
            self.contentTextView = UITextView.init(frame: (self.model?.frameModel?.contentFrame)!)
            
            self.bottomSepView = UIView.init(x: 0, y: (self.model?.frameModel?.commentFrame?.height)! - 10, w: APPWINDOWWIDTH, h: 10)
        }
        
        self.bottomSepView?.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(self.bottomSepView!)
        
        self.contentTextView?.isUserInteractionEnabled = false
        
        if (self.model?.content?.length)! > 100 && self.model?.isShowAll == false {
            
            self.zhankaiLbl = UILabel.init(frame: CGRect.init(x: (self.contentTextView?.frame.x)! + 1, y: (self.contentTextView?.frame.maxY)!, w: 100, h: UIFont.systemFont(ofSize: (self.model?.contentFont)!).lineHeight))
            
            self.zhankaiLbl?.font = UIFont.systemFont(ofSize: (self.model?.contentFont)!)
            self.zhankaiLbl?.textColor = UIColor.init(hexString: "8EBCFF")
            self.zhankaiLbl?.text = "展开"
            self.zhankaiLbl?.isUserInteractionEnabled = true
            self.contentView.addSubview(self.zhankaiLbl!)
            
            let tapGues = UITapGestureRecognizer.init(target: self, action: #selector(MusicSongCommentCell.showAllClick))
            self.zhankaiLbl?.addGestureRecognizer(tapGues)
        }
        
        let attStr : NSMutableAttributedString = NSMutableAttributedString.init(string: self.model!.content! as String)
        //段落设置
        let style : NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        style.alignment = NSTextAlignment.justified
        style.lineSpacing = (self.model?.lineSpace)!
        style.hyphenationFactor = 0.1
        style.lineBreakMode = NSLineBreakMode.byCharWrapping
        attStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: (self.model?.content?.length)!))
        //字体设置
        let ats_font = [NSFontAttributeName : UIFont.systemFont(ofSize: (self.model?.contentFont)!)]
        let ats_color = [NSForegroundColorAttributeName : UIColor.black]
        attStr.addAttributes(ats_font, range: NSRange.init(location: 0, length: (self.model?.content?.length)!))
        attStr.addAttributes(ats_color, range: NSRange.init(location: 0, length: (self.model?.content?.length)!))
        self.contentTextView?.attributedText = attStr
        self.contentView.addSubview(self.contentTextView!)

    }
    
    func showAllClick() -> Void {
        
        self.model?.isShowAll = true
        
        self.delegate?.musicSongCommentCellShowAllContent(cell: self)
        
    }
}
