//
//  MusicSongStoryCell.swift
//  OneCopy
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class MusicSongStoryCell: UITableViewCell {

    var model : MusicModel?
    
    var titleLbl        : UILabel?
    var writerLbl       : UILabel?
    var contentTextView : UITextView?
    var editorLbl       : UILabel?
    
    init(model: MusicModel) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        
        self.model = model
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        //标题
        self.titleLbl = UILabel.init(frame: (self.model?.frameModel?.musicStoryTitleFrame)!)
        self.titleLbl?.font = UIFont.boldSystemFont(ofSize: (self.model?.ms_titleFont)!)
        self.titleLbl?.text = self.model?.title
        self.contentView.addSubview(self.titleLbl!)
        
        //作者
        self.writerLbl = UILabel.init(frame: (self.model?.frameModel?.musicStoryWriterFrame)!)
        self.writerLbl?.font = UIFont.boldSystemFont(ofSize: (self.model?.ms_writerFont)!)
        self.writerLbl?.textColor = UIColor.init(hexString: "8EBCFF")
        self.writerLbl?.text = self.model?.writerName
        self.contentView.addSubview(self.writerLbl!)
        
        //内容
        self.contentTextView = UITextView.init(frame: (self.model?.frameModel?.musicStoryTextViewFrame)!)
        self.contentTextView?.isUserInteractionEnabled = false
        
        let attStr : NSMutableAttributedString = NSMutableAttributedString.init(string: self.model!.content! as String)
        //段落设置
        let style : NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        style.alignment = NSTextAlignment.justified
        style.lineSpacing = (self.model?.ms_lineSpace)!
        style.hyphenationFactor = 0.1
        style.lineBreakMode = NSLineBreakMode.byCharWrapping
        attStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: (self.model?.content?.length)!))
        //字体设置
        let ats_font = [NSFontAttributeName : UIFont.systemFont(ofSize: 14)]
        let ats_color = [NSForegroundColorAttributeName : UIColor.gray]
        attStr.addAttributes(ats_font, range: NSRange.init(location: 0, length: (self.model?.content?.length)!))
        attStr.addAttributes(ats_color, range: NSRange.init(location: 0, length: (self.model?.content?.length)!))
        
        self.contentTextView?.attributedText = attStr
        self.contentView.addSubview(self.contentTextView!)
    }
}
