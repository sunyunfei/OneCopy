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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "音乐"
        
        self.loadDatas()
        
        self.setupView()
    }

    func setupView() -> Void {
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: APPWINDOWHEIGHT - 64 - 49) , style: UITableViewStyle.grouped)
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.headerView = Bundle.main.loadNibNamed("MusicHeaderView", owner: nil, options: nil)?.first as! MusicHeaderView!
        self.headerView?.frame = CGRect.init(x: 0, y: 0, w: APPWINDOWWIDTH, h: 528)
        self.headerView?.delegate = self
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
        
        let model_1 : MusicModel = MusicModel.init()
        model_1.albumPic = "header"
        model_1.singerName = "Future Orients"
        model_1.singerIntro = "独立摇滚乐队"
        model_1.songName = "Cave"
        model_1.time = "Oct. 12,2016"
        model_1.title = "与青年摇滚乐手同居的日子"
        model_1.writerName = "硬毛猫"
        model_1.content = "2015年，一个冬天的傍晚，我站在十号线地铁口，眼前是大学城边上的小吃街，有头发湿漉漉滴着水的女生，左手拎澡筐，等在摊位前。我闻着她们身上腾腾冒起的，沐浴露和身体乳经体温焙出的的暖烘烘的香气，穿过一整条街的烤红薯、麻辣烫、烤鸡腿、铁板烧，拐进小区。\r\n \r\n这是我大学毕业后的第四个月，一直住在家里，每天跟爸妈吵架。那天早上我跟妈妈大吵一架，战火迅速从“你干嘛大清早放那些广场舞的破歌！”蔓延至家务、婚恋、人生乃至母女关系是否存续的高度。我怒气冲冲夺门而出，在地铁上玩手机，看到朋友分享的一则招租信息。\r\n \r\n硬件、租金和和地理位置合适。有两只可爱小母猫可以捏，有很多黑胶可以听。三个男生，都是正常工作的年轻人，不太一样的是业余都在玩乐队。“但是你想象中摇滚乐手的生活在我们身上都不存在，这个我们可以保证。”\r\n \r\n我火速约了看房，到了办公室发挥女性直觉，把这三个男孩的微博和豆瓣账号全部翻出来视奸一遍。超哥、小文和果真，都帅。下班时，我跟同事们讲，我去看房啦，以防万一，如果八点之前没有在群里说话，大家帮我报警！\r\n \r\n站在小区门口等超哥，过会儿一个穿黑色外套，四肢颀长的男生走过来，说话声音细小而温和。打过招呼后边走边聊。三个男生都是刚毕业，女朋友们也会来一起住。哦，那就好，我没有顾虑了。\r\n \r\n房子是四居，每人一间房。客厅不大，电视放在宜家小茶几上，旁边有唱机，满满两大箱碟片。后来小文给我演示唱片如何播放，吹去浮灰，置入唱盘，搭上唱针，调好速率，摁下旋钮，黑胶唱片转动起来，远看是同心圆的纹路，凑近却是曲曲折折的凹槽\r\n \r\n决定入住后先被拉进室友群，然后连上WI-FI，网络名是“一家人哟”密码则是“一家人你大爷”的拼音缩写，有些幽默。\r\n \r\n刚搬进去时，短发女生探头递进一碗洗净切好的菠萝：“如果你需要帮忙就随时讲吧~”然后刷地跑开，是果真的女朋友冰妹。还见到小文的女朋友舜舜和超哥的女朋友学妹。女孩子们会在周末做饭，大家围坐在地毯上，边吃边看各种乐队的纪录片，两只猫在我们的腿缝间跳来跳去。\r\n \r\n平日各自上班，回家就一头钻进房间。冰妹问：“跟他们住什么感觉？”我说：“以为是豆瓣月亮组，结果却是夕阳红养老院。”冰妹颔首：“嗯，我们都是具有老年气质的人。”\r\n \r\n超哥和学妹总是一起研发新菜谱，把各种奇怪蔬果塞入榨汁机，再带着满足的迷之微笑回到房间享用。学妹会从附近的市场买来几枝鲜花，高低错落插入酒瓶里，放在客厅一角，显出种漫不经心的美丽。\r\n \r\n果真很少做饭，只是在冰妹来时一同打下手。但是有一天他展现出了土耳其交换学习归来的非凡实力：用兵马司老板Michael送的烤箱，烤了一盘土豆+青红椒+鸡肉，据说这是当地特产。再撒上小文带回的贵阳六盘水辣椒面，无敌好吃。\r\n \r\n劳动的时候我们放歌。小文让我挑封面好看的放，我找来找去，竟摸出一张插画家庄汤尼画封面的七寸彩胶。他画过一系列游走在审查边缘线的作品，把教材插图风格的少先队员画得暴虐虚伪又下流，还因为给一个外国乐队巡演画的海报过于黄暴，演出直接被取消，理由竟然是辱华。\r\n \r\n那时候小文被边远邀请，给他的新歌《Beyond Love》配吉他旋律。小文总是很晚回家，先剪斑斑的MV，再设计演出海报和同事名片，最后抱着吉他发呆，“编不出来”。然后跳舞，玩剑玉，特别骄傲地告诉大家，虽然剑玉和滑板现在都不玩了，但是高中的时候就是靠它们追到了女朋友，一直好到现在！接着开始乱弹琴，最爱弹唱张含韵的歌。\r\n \r\n我记得有一天夜里，女朋友们要么不在要么睡了，我在客厅加班，果真他们乐队的主唱阿勇也在。阿勇是个学英语高级翻译的硕士在读生，写的歌词全是英文。有次他们在外地演出，我跟小文在家里抱着手机看直播。那个直播平台可能受众太广，什么人都有，实时弹幕出来一条：“唱的什么玩意儿，主唱四级过了么？”小文巨生气，恶狠狠怼回去，人家专八都过了！\r\n \r\n那天夜里大家聊起从前的生活，读过的书，小文抱着吉他坐在旁边随意地弹，阿勇打着FIFA2016。果真讲话时会带一点不易察觉的东北腔，他说那时候特别无聊，没什么事情做，高中和大学都是，也不爱讲话，于是就读李海鹏，到现在都会看他微博。阿勇刚刚踢进一个球，侧过头说：“啊，李海鹏！我也是！”我也是。\r\n \r\n小文后来搬走了。他所在的乐队叫鸟撞，Birdstriking。去年年底的时候成员九哥单位的领导一拍脑袋，哎那谁，你不是有个乐队吗，年会的时候过来演个出吧。于是一堆人拎着器材浩浩荡荡去了，那个单位是做军用设备的，保密级别挺高，进出门都费劲，演出场地在一个观众席所有座位都铺着红丝绒椅套的大礼堂，演之前领导讲话，中心思想是，大家要充分发扬预警机精神！让预警机精神走出国门！每个人都一脸严肃地鼓掌。演出完，还是政协会议级别的掌声。最后还给每个乐手授予一条斜肩缎带，红底黄字带圈金穗儿，表彰他们圆满完成了年会演出任务。\r\n \r\n我觉得特别奇妙。不知道他们唱了什么，感觉哪首歌的气质都不太预警机精神。然后今年夏天，他们乐队在微博做了个转发抽奖，送一台1：240空警500预警机模型。\r\n \r\n果真、超哥和阿勇，还有鼓手小锅组成的乐队叫The Eat，后来改名Future Orients，他们戏称自己是未来东方神起乐团、新东方乐队，弗特拉·奥伦茨演唱组合，随便怎么翻译都行。他们那时候刚跟兵马司签约，开始在吹万和鸟撞演出时作为嘉宾乐队暖场，也接受各地音乐节的邀请去走穴。在我搬进去的大半年里，他们把自己小站上本来就不多的歌曲demo删得一首不剩，只留下几张神秘写真，那是冰妹拍的。\r\n \r\n年初他们进棚录音，九个月后才发布专辑，还做了黑橙双色黑胶版本，定价二百五。其中有几首歌的长度到了七八分钟，而这首《Cave》，是丧心病狂的十分四十秒。粉丝朋友问，为什么做双黑胶？（潜台词：是不是一种圈钱？）果真说，歌太长了。阿勇说，歌虽然长，但是难听啊。\r\n \r\n我第一次听到《Cave》是今年夏天，在一个精酿啤酒节上。啤酒节现场闹哄哄，演出中不时有穿着开裆裤的小孩试图往舞台上爬，家长极少劝阻。年轻人们安安静静坐在台下，喝着后面买来的啤酒。那次调音有些不理想，声音显得单薄尖锐。果真和小文一样，弹吉他时从不看观众，只一心盯着自己的鞋尖儿，他们说这叫shoegaze，盯鞋派。先是几首熟悉的《Running》、《Idol》，然后我听到阿勇唱起了一首我从来没听过的歌，漫长又悲伤。歌词不断重复着，help me，hear me，再进一段编排缜密的器乐，然后阿勇说，I want to disappear。\r\n \r\n我们还会再年轻多久呢？对那些比我们老的人来说，这样的问题当然极为欠揍，但是在再年轻的人看来，我们确实不年轻了。每个人都有自己的时限，都卡在属于自己的山洞里，面对阴影，动弹不得，无法自救。一个自我安慰是，气数始终，到了就好了，过了就好了。\r\n \r\nFuture Orients即将从十月十六号起，踏上首张专辑发布后的全国巡演之路，我得一个人看家了。那天超哥说，阿毛，接下来就要麻烦你照顾猫猫啦。\r\n \r\n好的。龙虎少年们，演出加油呀！\r\n \r\n作者介绍:\r\n莹毛毛\r\n前读库小六，现工作睡觉十六小时之外的自由人。\r\n@莹毛毛毛毛毛毛毛毛毛毛毛毛毛毛"
        model_1.zanNum = 6
        model_1.commentNum = 66
        model_1.shareNum = 666
        model_1.isZan = true
        
        model_1.songContent = "I’m sitting here waiting for the sun／Till the day I feel that I won’t／Now I know I’m in your cave／Only to see your shadow in the mist. \r\n \r\nSo many times I’m running in fear／But you hold me back to light my fire／So many times I’m running in fear／I’m not Prometheus and have no holy fire \r\n \r\nHelp me, help me out of way／Hear me, hear me,please don't leave away \r\n \r\nHelp me, help me out of way／Hear me, hear me,please don't leave away \r\n \r\nI want to disappear"
        model_1.editorName = "（责任编辑：山山 sunshen@wufazhuce.com）"
        
        model_1.songAlbunName = "Eat or Die"
        model_1.songWriterName = "阿勇"
        model_1.contentWriterName = "Future Orients"
        model_1.albumCompanyName = "兵马司"
        model_1.soldTime = "2016年09月16日"
        model_1.albumType = "录音室专辑"
        
        model_1.layout()
        
        //热门 来4条 一条普通的 一条有评论的 一条有字多的 一条字多的且有评论的
        model_1.hotComments = Array.init()
        
        let comment_1 = MusicCommentModel.init()
        comment_1.commentUserName = "老董小号_1"
        comment_1.commentUserPic = ""
        comment_1.commentTime = "2016.10.14"
        comment_1.zanNum = 6
        comment_1.content = "一二三四五六七八九十一二三四"
        comment_1.haveReply = false
        comment_1.layout()
        comment_1.isShowAll = false
        comment_1.commentId = 1
        model_1.hotComments?.append(comment_1)
        
        let comment_2 = MusicCommentModel.init()
        comment_2.commentUserName = "老董小号_2"
        comment_2.commentUserPic = ""
        comment_2.commentTime = "2016.10.14"
        comment_2.zanNum = 6
        comment_2.content = "一二三四五六七八九十一二三四五六七八九十"
        comment_2.haveReply = true
        comment_2.replyName = "老董小号_1"
        comment_2.replyContent = "一二三四五六七八九十一二三四"
        comment_2.layout()
        comment_2.isShowAll = false
        comment_2.commentId = 2
        model_1.hotComments?.append(comment_2)
        
        let comment_3 = MusicCommentModel.init()
        comment_3.commentUserName = "老董小号_3"
        comment_3.commentUserPic = ""
        comment_3.commentTime = "2016.10.14"
        comment_3.zanNum = 6
        comment_3.content = "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"
        comment_3.haveReply = false
        comment_3.layout()
        comment_3.isShowAll = false
        comment_3.commentId = 3
        model_1.hotComments?.append(comment_3)
        
        
        let comment_4 = MusicCommentModel.init()
        comment_4.commentUserName = "老董小号_4"
        comment_4.commentUserPic = ""
        comment_4.commentTime = "2016.10.14"
        comment_4.zanNum = 6
        comment_4.content = "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"
        comment_4.haveReply = true
        comment_4.replyName = "老董小号_1"
        comment_4.replyContent = "一二三四五六七八九十一二三四"
        comment_4.layout()
        comment_4.isShowAll = false
        comment_4.commentId = 4
        model_1.hotComments?.append(comment_4)
        
        //普通4条
        model_1.normalComments = Array.init()
        
        let n_comment_1 = MusicCommentModel.init()
        n_comment_1.commentUserName = "老董小号_1"
        n_comment_1.commentUserPic = ""
        n_comment_1.commentTime = "2016.10.14"
        n_comment_1.zanNum = 6
        n_comment_1.content = "一二三四五六七八九十一二三四"
        n_comment_1.haveReply = false
        n_comment_1.layout()
        n_comment_1.isShowAll = false
        n_comment_1.commentId = 5
        model_1.normalComments?.append(n_comment_1)
        
        let n_comment_2 = MusicCommentModel.init()
        n_comment_2.commentUserName = "老董小号_2"
        n_comment_2.commentUserPic = ""
        n_comment_2.commentTime = "2016.10.14"
        n_comment_2.zanNum = 6
        n_comment_2.content = "一二三四五六七八九十一二三四五六七八九十"
        n_comment_2.haveReply = true
        n_comment_2.replyName = "老董小号_1"
        n_comment_2.replyContent = "一二三四五六七八九十一二三四"
        n_comment_2.layout()
        n_comment_2.isShowAll = false
        n_comment_2.commentId = 6
        model_1.normalComments?.append(n_comment_2)
        
        let n_comment_3 = MusicCommentModel.init()
        n_comment_3.commentUserName = "老董小号_3"
        n_comment_3.commentUserPic = ""
        n_comment_3.commentTime = "2016.10.14"
        n_comment_3.zanNum = 6
        n_comment_3.content = "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"
        n_comment_3.haveReply = false
        n_comment_3.layout()
        n_comment_3.isShowAll = false
        n_comment_3.commentId = 7
        model_1.normalComments?.append(n_comment_3)
        
        
        let n_comment_4 = MusicCommentModel.init()
        n_comment_4.commentUserName = "老董小号_4"
        n_comment_4.commentUserPic = ""
        n_comment_4.commentTime = "2016.10.14"
        n_comment_4.zanNum = 6
        n_comment_4.content = "一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"
        n_comment_4.haveReply = true
        n_comment_4.replyName = "老董小号_1"
        n_comment_4.replyContent = "一二三四五六七八九十一二三四"
        n_comment_4.layout()
        n_comment_4.isShowAll = false
        n_comment_4.commentId = 8
        model_1.normalComments?.append(n_comment_4)
        
        self.datas?.append(model_1)
    }
}
