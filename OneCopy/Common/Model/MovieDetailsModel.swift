//
//  MovieDetailsModel.swift
//  OneCopy
//
//  Created by 孙云飞 on 2017/1/16.
//  Copyright © 2017年 DJY. All rights reserved.
//

import UIKit

class MovieDetailsModel: NSObject {

    var icon:String?
    var des:String?
    var content:NSString?
    var image:String?
    var name:String?
    var type:String?
    var time:String?
    var actor:String?
    
    init(dic:Dictionary<String,AnyObject>) {
        
        super.init()
        icon = dic["icon"] as! String?
        des = dic["des"] as! String?
        content = dic["content"] as! NSString?
        image = dic["image"] as! String?
        name = dic["name"] as! String?
        type = dic["type"] as! String?
        time = dic["time"] as! String?
        actor = dic["actor"] as! String?
    }
}
