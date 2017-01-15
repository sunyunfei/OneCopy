//
//  LoginModel.swift
//  OneCopy
//
//  Created by 孙云飞 on 2017/1/15.
//  Copyright © 2017年 DJY. All rights reserved.
//

import UIKit

class LoginModel: NSObject {

    var userName:String?
    var userPassword:String?
    
    init(dic:Dictionary<String, Any>) {
        
        super.init()
        self.setValuesForKeys(dic)
    }
}
