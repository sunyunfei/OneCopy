//
//  MusicSongContentCell.swift
//  OneCopy
//
//  Created by Mac on 16/10/17.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class MusicSongContentCell: UITableViewCell {

    var model : MusicModel?
    var contentTextView : UITextView?
    var editorLbl : UILabel?
    
    init(model: MusicModel) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        
        self.model = model
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        
        self.contentTextView = UITextView.init(frame: (self.model?.frameModel?.songContentTextViewFrame)!)
        self.contentTextView?.isUserInteractionEnabled = false
        
        let attStr : NSMutableAttributedString = NSMutableAttributedString.init(string: self.model!.songContent! as String)
        //段落设置
        let style : NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        style.alignment = NSTextAlignment.justified
        style.lineSpacing = (self.model?.ms_lineSpace)!
        style.hyphenationFactor = 0.1
        style.lineBreakMode = NSLineBreakMode.byCharWrapping
        attStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: (self.model?.songContent?.length)!))
        //字体设置
        let ats_font = [NSFontAttributeName : UIFont.systemFont(ofSize: 14)]
        let ats_color = [NSForegroundColorAttributeName : UIColor.darkGray]
        attStr.addAttributes(ats_font, range: NSRange.init(location: 0, length: (self.model?.songContent?.length)!))
        attStr.addAttributes(ats_color, range: NSRange.init(location: 0, length: (self.model?.songContent?.length)!))
        
        self.contentTextView?.attributedText = attStr
        self.contentView.addSubview(self.contentTextView!)
        
        self.editorLbl = UILabel.init(frame: (self.model?.frameModel?.songContentEditorLblFrame)!)
        self.editorLbl?.font = UIFont.systemFont(ofSize: (self.model?.ms_editorFont)!)
        self.editorLbl?.textColor = UIColor.lightGray
        self.editorLbl?.text = self.model?.editorName
        self.contentView.addSubview(self.editorLbl!)
    }
}
