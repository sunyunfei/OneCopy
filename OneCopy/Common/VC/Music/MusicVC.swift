//
//  MusicVC.swift
//  OneCopy
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class MusicVC: BaseViewController,UITableViewDataSource,UITableViewDelegate,MusicSongCommentCellDelegate,MusicHeaderViewDelegate {

    //scrollView ,  contentSize是死的，只能左滑/右滑 一个屏幕宽度
    //scrollView 内容只有一个tableview ==>            [空白] [tableView] [空白]
    //当用户浏览第一个model内容时，scroll 不能右滑 , 即 :  [tableView] [空白] [空白]
    //同理，用户浏览最后一个model也是如此                 [空白] [空白] [tableView]
    //当用户翻scrollView的每一页时，判断model的index，来确定scrollView接下来的contentSize ,contentOffSet，并且改变该唯一tableView在scrollView中的坐标，达成视觉效果后，再调用重新载入数据方法，载入数据并显示
    //除tableViewHeader外，model中的内容应提前算好frame
    
    //tableview 分3组
    //第一组 : 两个单元格 : row1: 音乐故事／歌词/歌曲信息  row2:评论数点赞数...
    //第二组 : 热门评论
    //第三组 : 其它评论
    //整个tableview 加 MJFooter
    
    var scrollView : UIScrollView?
    var tableView  : UITableView?
    var headerView : MusicHeaderView?
    var datas      : [MusicModel]?
    var musicId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "音乐"
        
        self.loadDatas()
        
    }

    func setupView() -> Void {
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: APPWINDOWHEIGHT - 64 - 49) , style: UITableViewStyle.grouped)
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.headerView = Bundle.main.loadNibNamed("MusicHeaderView", owner: nil, options: nil)?.first as! MusicHeaderView!
        self.headerView?.frame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: 528)
        self.headerView?.delegate = self
        self.headerView?.musicId = musicId
        self.tableView?.tableHeaderView = self.headerView
        self.view.addSubview(self.tableView!)
        
        self.tableView?.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            
        })
        
        self.tableView?.mj_footer.endRefreshingWithNoMoreData()
    }
    
    func musicHeaderViewFuncBtnClick(view: MusicHeaderView, index: Int) {
        
        self.tableView?.reloadData()
    }
    
    //MARK:tableview D&D
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let model_1 : MusicModel = self.datas![0]
        
        if section == 0 {
            
            return 2
            
        }else if section == 1 {
            
            return (model_1.hotComments?.count)!
            
        }else if section == 2 {
            
            return (model_1.normalComments?.count)!
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model_1 : MusicModel = self.datas![0]
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                if self.headerView?.typeIndex == 0 {
                    
                    let cell : MusicSongStoryCell = MusicSongStoryCell.init(model: model_1)
                    return cell
                    
                }else if self.headerView?.typeIndex == 1 {
                    
                    let cell : MusicSongContentCell = MusicSongContentCell.init(model: model_1)
                    return cell
                    
                }else {
                    
                    //歌曲信息
                    let cell : MusicSongInfoCell = Bundle.main.loadNibNamed("MusicSongInfoCell", owner: nil, options: nil)?.first as! MusicSongInfoCell
                    cell.setModel(model : model_1)
                    return cell
                }
            }
            else if indexPath.row == 1 {
                
                //点赞/评论／分享
                let cell : MusicSongToolCell = Bundle.main.loadNibNamed("MusicSongToolCell", owner: nil, options: nil)?.first as! MusicSongToolCell
                return cell
            }
        
        } else if indexPath.section == 1 {
            
            //热门评论
            let cell : MusicSongCommentCell = MusicSongCommentCell.init(model: model_1.hotComments![indexPath.row])
            cell.delegate = self
            return cell
            
        } else if indexPath.section == 2 {
            
            //评论
            let cell : MusicSongCommentCell = MusicSongCommentCell.init(model: model_1.normalComments![indexPath.row])
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model_1 : MusicModel = self.datas![0]
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                if self.headerView?.typeIndex == 0 {
                    
                    //音乐故事
                    return (model_1.frameModel?.musicStoryFrame?.height)!
                    
                }else if self.headerView?.typeIndex == 1 {
                    
                    //歌词
                    return (model_1.frameModel?.songContentFrame?.height)!
                    
                }else {
                    
                    //歌曲信息
                    return 233
                }
            }
            else if indexPath.row == 1 {
                
                //点赞/评论／分享
                return 44
            }
            
        } else if indexPath.section == 1 {
            
            let model = model_1.hotComments![indexPath.row]
            
            if model.isShowAll! == true {
                
                return (model.frameModel?.allCommentFrame?.height)!
                
            }else {
                
                return (model.frameModel?.commentFrame?.height)!
            }
            
        } else if indexPath.section == 2 {
            
            let model = model_1.normalComments![indexPath.row]
            
            if model.isShowAll! == true {
                
                return (model.frameModel?.allCommentFrame?.height)!
                
            }else {
                
                return (model.frameModel?.commentFrame?.height)!
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let cv = UIView.init(frame: CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: 35))
            
            let lbl = UILabel.init(frame: CGRect.init(x: 15, y: 0, w: APPWINDOWWIDTH-30, h: 35))
            lbl.backgroundColor = UIColor.groupTableViewBackground
            lbl.textAlignment = NSTextAlignment.left
            lbl.font = UIFont.systemFont(ofSize: 12)
            lbl.text = "评论列表"
            lbl.textColor = UIColor.gray
            cv.addSubview(lbl)
            
            return cv
        }
        
        else if section == 1 {
            
            let cv = UIView.init(frame: CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: 35))
            
            let hotCommtentLbl = UILabel.init(frame: CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: 25))
            hotCommtentLbl.backgroundColor = UIColor.groupTableViewBackground
            hotCommtentLbl.textAlignment = NSTextAlignment.center
            hotCommtentLbl.font = UIFont.systemFont(ofSize: 13)
            hotCommtentLbl.text = "以上是热门评论"
            cv.addSubview(hotCommtentLbl)
            
            return cv

        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 35
            
        }
        
        else if section == 1 {
            
            return 35
            
        }
        
        return 0.2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.2
    }

    func musicSongCommentCellShowAllContent(cell: MusicSongCommentCell) {
        
        let model = self.datas?[0]
        //找到index
        for i in 0..<(model?.hotComments?.count)! {
            
            let commentModel = model?.hotComments?[i]
            
            if commentModel?.commentId == cell.model?.commentId {
                
                let indexP = IndexPath.init(row: i, section: 1)
                
                self.datas?[0].hotComments?[i].isShowAll = true
                
                self.tableView?.reloadRows(at: [indexP], with: UITableViewRowAnimation.none)
                
                return
            }
            
        }
        
        for i in 0..<(model?.normalComments?.count)! {
            
            let commentModel = model?.normalComments?[i]
            
            if commentModel?.commentId == cell.model?.commentId {
                
                let indexP = IndexPath.init(row: i, section: 2)
                
                self.datas?[0].normalComments?[i].isShowAll = true
                
                self.tableView?.reloadRows(at: [indexP], with: UITableViewRowAnimation.none)
                
                return
            }
        }
        
    }
    
    func loadDatas() -> Void {
        
        self.datas = Array.init()
        //网络请求
        HttpManager.musicGet { dic in
            
            let model_1 : MusicModel = MusicModel.init()
            model_1.musicId = dic["musicId"] as! Int?
            self.musicId = model_1.musicId// 给头部信息显示准备id
            model_1.albumPic = dic["albumPic"] as! String?
            model_1.singerName = dic["singerName"] as! String?
            model_1.singerIntro = dic["singerIntro"] as! String?
            model_1.songName = dic["songName"] as! String?
            model_1.time = dic["time"] as! String?
            model_1.title = dic["title"] as! String?
            model_1.writerName = dic["writerName"] as! String?
            model_1.content = dic["content"] as! NSString?
            model_1.zanNum = dic["zanNum"] as! Int?
            model_1.commentNum = dic["commentNum"] as! Int?
            model_1.shareNum = dic["shareNum"] as! Int?
            model_1.isZan = dic["isZan"] as! Bool?
            model_1.songContent = dic["songContent"] as! NSString?
            model_1.editorName = dic["editorName"] as! String?
            model_1.songAlbunName = dic["songAlbunName"] as! String?
            model_1.songWriterName = dic["songWriterName"] as! String?
            model_1.contentWriterName = dic["contentWriterName"] as! String?
            model_1.albumCompanyName = dic["albumCompanyName"] as! String?
            model_1.soldTime = dic["soldTime"] as! String?
            model_1.albumType = dic["albumType"] as! String?
            model_1.layout()
            
            //热门 来4条 一条普通的 一条有评论的 一条有字多的 一条字多的且有评论的
            model_1.hotComments = Array.init()
            //普通4条
            model_1.normalComments = Array.init()
            //评论请求数据
            HttpManager.musicCommentGet(musicId: model_1.musicId!, success: { dataArray in
                
                //遍历数组
                for dic:Dictionary<String,AnyObject> in dataArray{
                
                    let comment_1 = MusicCommentModel.init()
                    comment_1.commentUserName = dic["commentUserName"] as! String?
                    comment_1.commentUserPic = dic["commentUserPic"] as! String?
                    comment_1.commentTime = dic["commentTime"] as! String?
                    comment_1.zanNum = dic["zanNum"] as! Int?
                    comment_1.content = dic["content"] as! NSString?
                    //判断是否有追评
                    if dic["replyContent"] as? String == "null"{
                    
                        print("无追评")
                    }else{
                    
                        comment_1.replyContent = dic["replyContent"] as! NSString?
                    }
                    comment_1.haveReply = dic["haveReply"] as! Bool?
                    comment_1.layout()
                    comment_1.isShowAll = dic["showAll"] as! Bool?
                    comment_1.commentId = dic["commentId"] as! Int?
                    model_1.hotComments?.append(comment_1)
                    model_1.normalComments?.append(comment_1)
                }
                
                self.datas?.append(model_1)
                DispatchQueue.main.async {
                    
                    self.setupView()
                }
            })
        }
        
    }
}




//            let comment_1 = MusicCommentModel.init()
//            comment_1.commentUserName = "老董小号_1"
//            comment_1.commentUserPic = ""
//            comment_1.commentTime = "2016.10.14"
//            comment_1.zanNum = 6
//            comment_1.content = "一二三四五六七八九十一二三四"
//            comment_1.haveReply = false
//            comment_1.layout()
//            comment_1.isShowAll = false
//            comment_1.commentId = 1
//            model_1.hotComments?.append(comment_1)
//
//            let comment_2 = MusicCommentModel.init()
//            comment_2.commentUserName = "老董小号_2"
//            comment_2.commentUserPic = ""
//            comment_2.commentTime = "2016.10.14"
//            comment_2.zanNum = 6
//            comment_2.content = "一二三四五六七八九十一二三四五六七八九十"
//            comment_2.haveReply = true
//            comment_2.replyName = "老董小号_1"
//            comment_2.replyContent = "一二三四五六七八九十一二三四"
//            comment_2.layout()
//            comment_2.isShowAll = false
//            comment_2.commentId = 2
//            model_1.hotComments?.append(comment_2)
//
//            let comment_3 = MusicCommentModel.init()
//            comment_3.commentUserName = "老董小号_3"
//            comment_3.commentUserPic = ""
//            comment_3.commentTime = "2016.10.14"
//            comment_3.zanNum = 6
//            comment_3.content = "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"
//            comment_3.haveReply = false
//            comment_3.layout()
//            comment_3.isShowAll = false
//            comment_3.commentId = 3
//            model_1.hotComments?.append(comment_3)
//
//
//            let comment_4 = MusicCommentModel.init()
//            comment_4.commentUserName = "老董小号_4"
//            comment_4.commentUserPic = ""
//            comment_4.commentTime = "2016.10.14"
//            comment_4.zanNum = 6
//            comment_4.content = "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"
//            comment_4.haveReply = true
//            comment_4.replyName = "老董小号_1"
//            comment_4.replyContent = "一二三四五六七八九十一二三四"
//            comment_4.layout()
//            comment_4.isShowAll = false
//            comment_4.commentId = 4
//            model_1.hotComments?.append(comment_4)

//普通4条
//            model_1.normalComments = Array.init()
//
//            let n_comment_1 = MusicCommentModel.init()
//            n_comment_1.commentUserName = "老董小号_1"
//            n_comment_1.commentUserPic = ""
//            n_comment_1.commentTime = "2016.10.14"
//            n_comment_1.zanNum = 6
//            n_comment_1.content = "一二三四五六七八九十一二三四"
//            n_comment_1.haveReply = false
//            n_comment_1.layout()
//            n_comment_1.isShowAll = false
//            n_comment_1.commentId = 5
//            model_1.normalComments?.append(n_comment_1)
//
//            let n_comment_2 = MusicCommentModel.init()
//            n_comment_2.commentUserName = "老董小号_2"
//            n_comment_2.commentUserPic = ""
//            n_comment_2.commentTime = "2016.10.14"
//            n_comment_2.zanNum = 6
//            n_comment_2.content = "一二三四五六七八九十一二三四五六七八九十"
//            n_comment_2.haveReply = true
//            n_comment_2.replyName = "老董小号_1"
//            n_comment_2.replyContent = "一二三四五六七八九十一二三四"
//            n_comment_2.layout()
//            n_comment_2.isShowAll = false
//            n_comment_2.commentId = 6
//            model_1.normalComments?.append(n_comment_2)
//
//            let n_comment_3 = MusicCommentModel.init()
//            n_comment_3.commentUserName = "老董小号_3"
//            n_comment_3.commentUserPic = ""
//            n_comment_3.commentTime = "2016.10.14"
//            n_comment_3.zanNum = 6
//            n_comment_3.content = "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"
//            n_comment_3.haveReply = false
//            n_comment_3.layout()
//            n_comment_3.isShowAll = false
//            n_comment_3.commentId = 7
//            model_1.normalComments?.append(n_comment_3)
//
//
//            let n_comment_4 = MusicCommentModel.init()
//            n_comment_4.commentUserName = "老董小号_4"
//            n_comment_4.commentUserPic = ""
//            n_comment_4.commentTime = "2016.10.14"
//            n_comment_4.zanNum = 6
//            n_comment_4.content = "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"
//            n_comment_4.haveReply = true
//            n_comment_4.replyName = "老董小号_1"
//            n_comment_4.replyContent = "一二三四五六七八九十一二三四"
//            n_comment_4.layout()
//            n_comment_4.isShowAll = false
//            n_comment_4.commentId = 8
//            model_1.normalComments?.append(n_comment_4)


//            self.datas?.append(model_1)
//            DispatchQueue.main.async {
//
//                self.setupView()
//            }
