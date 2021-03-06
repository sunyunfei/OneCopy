//
//  MusicHeaderView.swift
//  OneCopy
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit
import AVFoundation
protocol MusicHeaderViewDelegate {
    
    
    /// 点击切换按钮
    ///
    /// - parameter view:  self
    /// - parameter index: 0 音乐故事 1 歌词 2 歌曲介绍
    ///
    /// - returns: void
    func musicHeaderViewFuncBtnClick(view : MusicHeaderView , index : Int) -> Void
    
}

class MusicHeaderView: UIView {
 
    var delegate : MusicHeaderViewDelegate?
    //音乐播放管理
    var player:AVPlayer?
    //数据
    var musicId:Int?{
    
        didSet{
        
         //网络请求
        self.getData()
        }
    }
    var typeIndex : Int = 0
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var singerName: UILabel!
    @IBOutlet weak var introLbl: UILabel!
    @IBOutlet weak var songNameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var mainPicView: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var btn_1: UIButton!
    @IBOutlet weak var btn_2: UIButton!
    @IBOutlet weak var btn_3: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardView.layer.cornerRadius = 4
        self.cardView.layer.shadowColor = UIColor.black.cgColor
        self.cardView.layer.shadowRadius = 2
        self.cardView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        self.cardView.layer.shadowOpacity = 0.4
        self.headerImgView.layer.cornerRadius = 25
        self.headerImgView.layer.masksToBounds = true
        self.btn_1.isSelected = true
        
    }
    
    @IBAction func songStoryBtnClick(_ sender: UIButton) {
        
        self.btn_1.isSelected = true
        self.btn_2.isSelected = false
        self.btn_3.isSelected = false
        
        self.typeIndex = 0
        self.delegate?.musicHeaderViewFuncBtnClick(view: self, index: 0)
    }

    
    @IBAction func songContentBtnClick(_ sender: UIButton) {
        
        self.btn_1.isSelected = false
        self.btn_2.isSelected = true
        self.btn_3.isSelected = false

        self.typeIndex = 1
        self.delegate?.musicHeaderViewFuncBtnClick(view: self, index: 1)
    }
    
    @IBAction func songInfoBtnClick(_ sender: UIButton) {
        
        self.btn_1.isSelected = false
        self.btn_2.isSelected = false
        self.btn_3.isSelected = true
        
        self.typeIndex = 2
        self.delegate?.musicHeaderViewFuncBtnClick(view: self, index: 2)
    }
    
    //音乐创建
    func createMusic(urlStr:String){
    
        let item = AVPlayerItem.init(url: URL.init(string: urlStr)!)
        player = AVPlayer.init(playerItem: item)
        print("play music")
    }
    
    //点击播放音乐按钮
    @IBAction func clickPlayBtn(_ sender: UIButton) {
        
        if !sender.isSelected {
            
            //开始播放
            player?.play()
        }else{
        
            //停止播放
            player?.pause()
        }
        
        sender.isSelected = !sender.isSelected
    }

    //网络数据请求
    func getData(){
    
        HttpManager.musciInfoGet(musicId: musicId!, success: {dic in
        
            //数据显示
            DispatchQueue.main.async {
                
                self.headerImgView.image = UIImage.init(named: dic["image"] as! String )
                self.songNameLbl.text = dic["name"] as! String?
                self.typeLbl.text = dic["type"] as! String?
                self.timeLbl.text = dic["time"] as! String?
                self.mainPicView.image = UIImage.init(named: dic["icon"] as! String)
                //音乐
                self.createMusic(urlStr: dic["url"] as! String)
            }
        })
    }
}
