//
//  HttpManager.swift
//  OneCopy
//
//  Created by 孙云飞 on 2017/1/15.
//  Copyright © 2017年 DJY. All rights reserved.
//

import UIKit
import Alamofire
class HttpManager: NSObject {
    
    //登录请求
    static func loginForGet(account:String,password:String,success:@escaping (_ model:LoginModel?)->Void)->Void{
    
        let urlStr = "http://localhost:8080/user/queryUser?userName="+account + "&userPassword="+password
        Alamofire.request(urlStr).responseJSON { response in
            //debugPrint(response)
            
            if let json:Dictionary<String,AnyObject> = response.result.value as! Dictionary<String, AnyObject>? {
                if json["code"] as! Int == 1 {
                
                    //说明请求成功了
                    print(json["data"]!)
                    let model:LoginModel = LoginModel.init(dic:json["data"]! as! Dictionary<String, Any>)
                    DispatchQueue.main.async {
                        
                        //回調数据
                        success(model)
                    }
                    
                }else{
                
                    print(json["message"]!)
                }
            }else{
            
                //接口没有请求成功
                print("error15501079050")
            }
        }
    }
    
    //注册请求
    static func registerForGet(account:String,password:String)->Void{
    
       let urlStr = "http://localhost:8080/user/insertUser?userName="+account + "&userPassword="+password
        Alamofire.request(urlStr).responseJSON { response in
            //debugPrint(response)
            
            if let json:Dictionary<String,AnyObject> = response.result.value as! Dictionary<String, AnyObject>? {
                if json["code"] as! Int == 1 {
                    
                    //说明请求成功了
                    DispatchQueue.main.async {
                        
                        //成功
                        print(json["message"]!)
                    }
                    
                }else{
                    
                    print(json["message"]!)
                }
            }else{
                
                //接口没有请求成功
                print("error")
            }
        }
    }
    
    //首页数据请求
    static func homeGet(success:@escaping (_ dataArray:[Dictionary<String,AnyObject>])->Void)->Void{
    
        let urlStr = "http://localhost:8080/home/query?userName="+UserManager.obtainUserIdForLocation()!
        Alamofire.request(urlStr).responseJSON { response in
            
            if let json:Dictionary<String,AnyObject> = response.result.value as! Dictionary<String, AnyObject>? {
                if json["code"] as! Int == 1 {
                    
                    //说明请求成功了
                    //把数据传递过去
                    success(json["data"] as! [Dictionary<String, AnyObject>]);
                    
                }else{
                    
                    print(json["message"]!)
                }
            }else{
                
                //接口没有请求成功
                print("error")
            }
        }
    }
    
    //阅读内容请求
    static func readConmentGet(success:@escaping (_ dataArray:[Dictionary<String,AnyObject>])->Void)->Void{
    
        let urlStr = "http://localhost:8080/read/queryContent?userName="+UserManager.obtainUserIdForLocation()!
        Alamofire.request(urlStr).responseJSON { response in
            
            if let json:Dictionary<String,AnyObject> = response.result.value as! Dictionary<String, AnyObject>? {
                if json["code"] as! Int == 1 {
                    
                    //说明请求成功了
                    //把数据传递过去
                    success(json["data"] as! [Dictionary<String, AnyObject>]);
                    
                }else{
                    
                    print(json["message"]!)
                }
            }else{
                
                //接口没有请求成功
                print("error")
            }
        }
    }
    
}
