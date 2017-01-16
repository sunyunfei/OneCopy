//
//  MovieListModel.swift
//  OneCopy
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class MovieListModel: BaseModel {

    //var image : UIImage?
    var image:String?
    var movieId :Int?
    
    init(dic:Dictionary<String,AnyObject>) {
        
       super.init()
       //image = UIImage.init(named: dic["movieImage"] as! String)
       image = dic["movieImage"] as! String?
       movieId = dic["movieId"] as? Int
    }
    
}
