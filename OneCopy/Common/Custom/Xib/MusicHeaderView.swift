//
//  MusicHeaderView.swift
//  OneCopy
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

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

}
