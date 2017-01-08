//
//  MusicSongInfoCell.swift
//  OneCopy
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class MusicSongInfoCell: UITableViewCell {

    var model : MusicModel?
    
    @IBOutlet weak var suoshuzhuanji: UILabel!
    @IBOutlet weak var yanchangzhe: UILabel!
    @IBOutlet weak var zuoci: UILabel!
    @IBOutlet weak var zuoqu: UILabel!
    @IBOutlet weak var changpiangongsi: UILabel!
    @IBOutlet weak var faxingshijian: UILabel!
    @IBOutlet weak var zhuanjileibie: UILabel!
    
    
    func setModel(model : MusicModel) -> Void {
        
        self.model = model
        
        self.suoshuzhuanji.text = String.init(format: "所属专辑: %@",model.songAlbunName!)
        self.yanchangzhe.text = String.init(format: "演唱者: %@",model.singerName!)
        self.zuoci.text = String.init(format: "作词: %@",model.contentWriterName!)
        self.zuoqu.text = String.init(format: "作曲: %@",model.songWriterName!)
        self.changpiangongsi.text = String.init(format: "唱片公司: %@",model.albumCompanyName!)
        self.faxingshijian.text = String.init(format: "发行时间: %@",model.soldTime!)
        self.zhuanjileibie.text = String.init(format: "专辑类别: %@",model.albumType!)
    }
    
}
