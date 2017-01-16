//
//  MusicModel.swift
//  OneCopy
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class MusicCommentFrameModel : BaseModel {
    
    var headerImageFrame : CGRect?
    var nameLblFrame     : CGRect?
    var timeLblFrame     : CGRect?
    var zanNumFrame      : CGRect?
    var zanImageFrame    : CGRect?
    var contentFrame     : CGRect?
    
    var allContentFrame  : CGRect?
    
    var replyFrame       : CGRect?
    var replyLblFrame    : CGRect?
    var replyContentFrame: CGRect?
    
    var commentFrame     : CGRect?
    var allCommentFrame  : CGRect?
}

class MusicCommentModel: BaseModel {
    
    var commentId       : Int?
    var commentUserName : String?
    var commentUserPic  : String?
    var commentTime     : String?
    
    var zanNum          : Int?
    var content         : NSString?
    
    var haveReply       : Bool?
    var replyName       : String?
    var replyContent    : NSString?
    var isShowAll       : Bool?
    var frameModel      : MusicCommentFrameModel?
    
    let topMargin        : CGFloat = 20
    let sidePadding      : CGFloat = 15
    let headerImgSize    : CGFloat = 40
    let nameTopPadding   : CGFloat = 5
    let namePadding      : CGFloat = 7
    let nameFont         : CGFloat = 14
    let timeFont         : CGFloat = 12
    let contentPadding   : CGFloat = 15
    let replyContentFont : CGFloat = 13
    let replyNameFont    : CGFloat = 13
    let contentFont      : CGFloat = 14
    let zanNumFont       : CGFloat = 12
    let zanW             : CGFloat = 35
    let zanH             : CGFloat = 20 - 5
    let zanImgW          : CGFloat = 22 - 5
    let zanImgH          : CGFloat = 20 - 5
    let lineSpace        : CGFloat = 10
    
    let replyInsidePadding  : CGFloat = 15
    let replyOutsidePadding : CGFloat = 15
    
    func layout() -> Void {
        
        self.frameModel = MusicCommentFrameModel.init()
        
        self.frameModel?.headerImageFrame = CGRect.init(x: sidePadding, y: topMargin - 5, w: headerImgSize, h: headerImgSize)
        
        //名称
        self.frameModel?.nameLblFrame = CGRect.init(x: (self.frameModel?.headerImageFrame?.maxX)! + namePadding, y:(self.frameModel?.headerImageFrame?.x)! + nameTopPadding, w: 200, h: UIFont.systemFont(ofSize: nameFont).lineHeight)
        
        //时间
        self.frameModel?.timeLblFrame = CGRect.init(x: (self.frameModel?.nameLblFrame?.x)!, y: (self.frameModel?.nameLblFrame?.maxY)!, w: 150, h: UIFont.systemFont(ofSize: timeFont).lineHeight)
        
        //赞
        self.frameModel?.zanNumFrame = CGRect.init(x: APPWINDOWWIDTH - sidePadding - zanW, y: (self.frameModel?.nameLblFrame?.y)!, w: zanW, h: zanH)
        self.frameModel?.zanImageFrame = CGRect.init(x: (self.frameModel?.zanNumFrame?.x)! - zanImgW, y: (self.frameModel?.zanNumFrame?.y)!, w: zanImgW, h: zanImgH)
        
        if self.haveReply == true {
            
            //算回复那条消息的高
            self.frameModel?.replyLblFrame = CGRect.init(x: replyInsidePadding, y: replyInsidePadding, w: APPWINDOWWIDTH - replyInsidePadding * 2 - replyOutsidePadding * 2, h: UIFont.systemFont(ofSize: replyNameFont).lineHeight)
            print(self.replyContent!)
            let r_titleSize = Tools.getTextRectSize(text: (self.replyContent)! as NSString, font: UIFont.systemFont(ofSize: replyContentFont), size: CGSize.init(width: (self.frameModel?.replyLblFrame?.width)!, height:CGFloat(MAXFLOAT)))
            //1.算大概有多少行
            let r_rowNum : CGFloat = r_titleSize.height / (UIFont.systemFont(ofSize: replyContentFont).lineHeight)
            //2.原高度 ＋ 总行间距 ＋ 误差
            let r_contentHeight = r_titleSize.height + (r_rowNum - 1) * lineSpace + 10.0
            
            self.frameModel?.replyContentFrame = CGRect.init(x: replyInsidePadding, y: (self.frameModel?.replyLblFrame?.maxY)! + replyInsidePadding, w: (self.frameModel?.replyLblFrame?.width)!, h: r_contentHeight)
            
            self.frameModel?.replyFrame = CGRect.init(x: replyOutsidePadding, y: (self.frameModel?.timeLblFrame?.maxY)! + replyOutsidePadding, w: APPWINDOWWIDTH - replyOutsidePadding * 2, h: r_contentHeight + replyInsidePadding * 3 + (self.frameModel?.replyLblFrame?.height)!)
            
            let titleSize = Tools.getTextRectSize(text: (self.content)! as NSString, font: UIFont.systemFont(ofSize: contentFont), size: CGSize.init(width: (self.frameModel?.replyFrame?.width)!, height:CGFloat(MAXFLOAT)))
            //1.算大概有多少行
            let rowNum : CGFloat = titleSize.height / (UIFont.systemFont(ofSize: contentFont).lineHeight)
            //2.原高度 ＋ 总行间距 ＋ 误差
            let contentHeight = titleSize.height + (rowNum - 1) * lineSpace + 10.0
            
            //所有内容的高
            self.frameModel?.allContentFrame = CGRect.init(x: replyOutsidePadding, y: (self.frameModel?.replyFrame?.maxY)! + replyOutsidePadding, w: (self.frameModel?.replyFrame?.width)!, h: contentHeight + lineSpace + (UIFont.systemFont(ofSize: contentFont).lineHeight))
            
            self.frameModel?.allCommentFrame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: (self.frameModel?.allContentFrame?.maxY)! + replyOutsidePadding + 12)
            
            //如果内容大于100个字,再算折叠内容的高 即 0-50字，剩下50字是折叠进去的 即上面高度的一半 + 一行 （展开2字）＋ 误差
            if (self.content?.length)! > 100 {
                
                self.frameModel?.contentFrame = CGRect.init(x: replyOutsidePadding, y: (self.frameModel?.replyFrame?.maxY)! + replyOutsidePadding, w: (self.frameModel?.replyFrame?.width)!, h: contentHeight / 2 + lineSpace + UIFont.systemFont(ofSize: contentFont).lineHeight + 10)
                
                self.frameModel?.commentFrame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: (self.frameModel?.contentFrame?.maxY)! + replyOutsidePadding + 12 + 15)
                
            } else {
                
                self.frameModel?.contentFrame = self.frameModel?.allContentFrame
                
                
                self.frameModel?.commentFrame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: (self.frameModel?.contentFrame?.maxY)! + replyOutsidePadding + 12)
            }
            
            
            
        } else {  //这个地方可以优化，这里偷懒就不优化了
            
            let titleSize = Tools.getTextRectSize(text: (self.content)! as NSString, font: UIFont.systemFont(ofSize: contentFont), size: CGSize.init(width: APPWINDOWWIDTH - replyOutsidePadding * 2, height:CGFloat(MAXFLOAT)))
            //1.算大概有多少行
            let rowNum : CGFloat = titleSize.height / (UIFont.systemFont(ofSize: contentFont).lineHeight)
            //2.原高度 ＋ 总行间距 ＋ 误差
            let contentHeight = titleSize.height + (rowNum - 1) * lineSpace + 10.0
            
            //所有内容的高
            self.frameModel?.allContentFrame = CGRect.init(x: replyOutsidePadding, y: (self.frameModel?.timeLblFrame?.maxY)! + replyOutsidePadding, w: APPWINDOWWIDTH - replyOutsidePadding * 2, h: contentHeight + lineSpace + (UIFont.systemFont(ofSize: contentFont).lineHeight))
            
            self.frameModel?.allCommentFrame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: (self.frameModel?.allContentFrame?.maxY)! + replyOutsidePadding + 12)
            
            //如果内容大于100个字,再算折叠内容的高 即 0-50字，剩下50字是折叠进去的 即上面高度的一半 + 一行 （展开2字）＋ 误差
            if (self.content?.length)! > 100 {
                
                self.frameModel?.contentFrame = CGRect.init(x: replyOutsidePadding, y: (self.frameModel?.timeLblFrame?.maxY)! + replyOutsidePadding, w: (self.frameModel?.allContentFrame?.width)!, h: contentHeight / 2 + lineSpace + UIFont.systemFont(ofSize: contentFont).lineHeight + 10)
                
                self.frameModel?.commentFrame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: (self.frameModel?.contentFrame?.maxY)! + replyOutsidePadding + 12 + 15)
                
            } else {
                
                self.frameModel?.contentFrame = self.frameModel?.allContentFrame
                
                self.frameModel?.commentFrame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: (self.frameModel?.contentFrame?.maxY)! + replyOutsidePadding + 12)
            }
        }
        
    }
}


class MusicFrameModel: BaseModel {
    
    var musicStoryFrame          : CGRect?
    var musicStoryTitleFrame     : CGRect?
    var musicStoryWriterFrame    : CGRect?
    var musicStoryTextViewFrame  : CGRect?
    var musicStoryEditorLblFrame : CGRect?
    
    var songContentFrame         : CGRect?
    var songContentTextViewFrame : CGRect?
    var songContentEditorLblFrame: CGRect?
    
}

class MusicModel: BaseModel {
    
    //id
    var musicId : Int?
    //头部
    var albumPic    : String?
    var headerImg   : String?
    var singerName  : String?
    var singerIntro : String?
    var songName    : String?
    var time        : String?
    
    //音乐故事
    var title       : String?
    var writerName  : String?
    var content     : NSString?
    
    var writerIntro : String?
    var editorName  : String?
    var editorEmail : String?
    
    var zanNum      : Int?
    var commentNum  : Int?
    var shareNum    : Int?
    var isZan       : Bool?
    
    var songContent : NSString?
    
    var songAlbunName     : String?
    var songWriterName    : String?
    var contentWriterName : String?
    var albumCompanyName  : String?
    var soldTime          : String?
    var albumType         : String?
    
    var hotComments       : [MusicCommentModel]?
    var normalComments    : [MusicCommentModel]?
    
    var frameModel        : MusicFrameModel?
    
    //音乐故事
    let ms_topMargin    : CGFloat = 20
    let ms_bottomMargin : CGFloat = 20
    let ms_sidePadding  : CGFloat = 10
    let ms_textPadding  : CGFloat = 6
    let ms_titleFont    : CGFloat = 17
    let ms_writerFont   : CGFloat = 12
    let ms_writerPadding: CGFloat = 20
    let ms_contentFont  : CGFloat = 14
    let ms_lineSpace    : CGFloat = 8
    let ms_editorFont   : CGFloat = 12
    
    //歌词
    let s_topMargin     : CGFloat = 20
    
    func layout() -> Void {
        
        self.frameModel = MusicFrameModel.init()
        
        //音乐故事
        //算title的size ,宽是确定的
        let titleSize = Tools.getTextRectSize(text: self.title! as NSString, font: UIFont.systemFont(ofSize: ms_titleFont), size: CGSize.init(width: APPWINDOWWIDTH - ms_sidePadding * 2, height:CGFloat(MAXFLOAT)))
        
        //title
        self.frameModel?.musicStoryTitleFrame = CGRect.init(x: ms_sidePadding, y: ms_topMargin, w: APPWINDOWWIDTH - ms_sidePadding * 2, h: titleSize.height)
        
        //作者
        self.frameModel?.musicStoryWriterFrame = CGRect.init(x: ms_sidePadding, y: (self.frameModel?.musicStoryTitleFrame?.maxY)! + ms_writerPadding, w: 233, h: UIFont.systemFont(ofSize: ms_writerFont).lineHeight)
        
        //内容 , 有换行符，循环查找\r\n，找到一个记录一次，最后内容的高度 = 没换行符每一段文字的高度 + 空白行数 * 行高 (有间距计算间距)
        let tempContent : NSString = NSString.init(string: self.content!)
        //\r\n的次数
        let prgs = tempContent.components(separatedBy: "\r\n")
        //空白行的次数
        let count = tempContent.components(separatedBy: "\r\n \r\n").count
        //每一段高度的和
        var partH : CGFloat = 0
        //tempContent去掉\r\n ，并计算每一段的高度，最后加起来
        for i in 0..<prgs.count {
            
            let partStr = prgs[i]
            
            let titleSize = Tools.getTextRectSize(text: partStr as NSString, font: UIFont.systemFont(ofSize: ms_contentFont), size: CGSize.init(width: APPWINDOWWIDTH - ms_textPadding * 2, height:CGFloat(MAXFLOAT)))
            //1.算大概有多少行
            let rowNum : CGFloat = titleSize.height / (UIFont.systemFont(ofSize: ms_contentFont).lineHeight)
            //2.原高度 ＋ 总行间距
            let contentHeight = titleSize.height + (rowNum - 1) * ms_lineSpace
            
            partH += contentHeight
        }
        //所有的总高度
        let contentH = partH + CGFloat.init(count) * (UIFont.systemFont(ofSize: ms_contentFont).lineHeight + ms_lineSpace) + 10
        self.frameModel?.musicStoryTextViewFrame = CGRect.init(x: ms_textPadding, y: (self.frameModel?.musicStoryWriterFrame?.maxY)! + ms_writerPadding, w: APPWINDOWWIDTH - ms_textPadding * 2, h: contentH)
        
        self.frameModel?.musicStoryFrame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: (self.frameModel?.musicStoryTextViewFrame?.maxY)! + ms_bottomMargin)
        
        ////////
        //歌词 , 这个地方可以抽取一个方法 ，现在就算了
        //内容和 上面的内容类似
        let s_tempContent : NSString = NSString.init(string: self.songContent!)
        //\r\n的次数
        let s_prgs = s_tempContent.components(separatedBy: "\r\n")
        //空白行的次数
        let s_count = s_tempContent.components(separatedBy: "\r\n \r\n").count
   
        //每一段高度的和
        var s_partH : CGFloat = 0
        //tempContent去掉\r\n ，并计算每一段的高度，最后加起来
        for i in 0..<s_prgs.count {
            
            let partStr = s_prgs[i]
            
            let titleSize = Tools.getTextRectSize(text: partStr as NSString, font: UIFont.systemFont(ofSize: ms_contentFont), size: CGSize.init(width: APPWINDOWWIDTH - ms_sidePadding * 2, height:CGFloat(MAXFLOAT)))
            //1.算大概有多少行
            let rowNum : CGFloat = titleSize.height / (UIFont.systemFont(ofSize: ms_contentFont).lineHeight)
            //2.原高度 ＋ 总行间距 ＋ 误差
            let contentHeight = titleSize.height + (rowNum - 1) * ms_lineSpace
            
            s_partH += contentHeight
        }
        //所有的总高度
        let s_contentH = s_partH + CGFloat.init(s_count) * (UIFont.systemFont(ofSize: ms_contentFont).lineHeight + ms_lineSpace) + 10
        self.frameModel?.songContentTextViewFrame = CGRect.init(x: ms_sidePadding, y: s_topMargin, w: APPWINDOWWIDTH - ms_sidePadding * 2, h: s_contentH)
        
        self.frameModel?.songContentEditorLblFrame = CGRect.init(x: ms_sidePadding * 2, y: (self.frameModel?.songContentTextViewFrame?.maxY)! + ms_sidePadding, w: APPWINDOWWIDTH - ms_sidePadding * 2, h: UIFont.systemFont(ofSize: ms_editorFont).lineHeight)
        
        self.frameModel?.songContentFrame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: (self.frameModel?.songContentEditorLblFrame?.maxY)! + ms_bottomMargin)
        
    }
    
}
