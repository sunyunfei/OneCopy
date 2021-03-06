//
//  UserManager.swift
//  OneCopy
//
//  Created by 孙云飞 on 2017/1/9.
//  Copyright © 2017年 DJY. All rights reserved.
//

import UIKit
let user_name:String = "user_name"
class UserManager: NSObject {

    //存入用户的id
    static func saveUserIdForLocation(userName:String){
    
        let defaults = UserDefaults.standard
        defaults.set(userName, forKey: user_name)
        defaults.synchronize()
    }
    
    
    //判断本地是否有userId数据
    static func judgeUserIdIsInLocation()->Bool{
    
        let defaults = UserDefaults.standard
//        var str: String = ""
        let str:String? = defaults.object(forKey: user_name) as? String
        if str == nil || str == "" || (str?.length)! < 1 {
            
            //没有登录
            return false
        }
        return true
    }
    
    
    //获取userid
    static func obtainUserIdForLocation()->String?{
    
       let defaults = UserDefaults.standard
       return (defaults.object(forKey: user_name) as! String?)!
    }
}
