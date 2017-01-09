//
//  AppDelegate.swift
//  OneCopy
//
//  Created by Mac on 16/9/29.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        //判断是否登录
        UserManager.judgeUserIdIsInLocation() == true ? (MainViewManager.createApp(rootWindow: window!)) : (loadLoginVC()) ;
        
        return true
    }
    
    //加载登录界面
    func loadLoginVC(){
        //打开login
        let story:UIStoryboard = UIStoryboard.init(name: "LoginStoryboard", bundle: nil)
        let loginVC = story.instantiateViewController(withIdentifier: "login")
        window?.rootViewController = loginVC
    }

}

