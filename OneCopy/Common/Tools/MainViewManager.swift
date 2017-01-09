//
//  MainViewManager.swift
//  OneCopy
//
//  Created by 孙云飞 on 2017/1/9.
//  Copyright © 2017年 DJY. All rights reserved.
//

import UIKit

class MainViewManager: NSObject {

    static func createApp(rootWindow:UIWindow){
    
        //主tabbar
        let tabbar : TabbarController = TabbarController();
        
        //nav
        let mainNav : UINavigationController = UIStoryboard.init(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "MainPageNavID") as! UINavigationController;
        mainNav.tabBarItem.title = "首页";
        mainNav.tabBarItem.image = UIImage.init(named: "shouye")
        
        let readNav : UINavigationController = UIStoryboard.init(name: "Read", bundle: nil).instantiateViewController(withIdentifier: "ReadNavID") as! UINavigationController;
        readNav.tabBarItem.title = "阅读";
        readNav.tabBarItem.image = UIImage.init(named: "yuedu")
        
        let musicNav : UINavigationController = UIStoryboard.init(name: "Music", bundle: nil).instantiateViewController(withIdentifier: "MusicNavID") as! UINavigationController;
        musicNav.tabBarItem.title = "音乐";
        musicNav.tabBarItem.image = UIImage.init(named: "yinyue")
        
        let movieNav : UINavigationController = UIStoryboard.init(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "MovieNavID") as! UINavigationController;
        movieNav.tabBarItem.title = "电影";
        movieNav.tabBarItem.image = UIImage.init(named: "dianying")
        
        tabbar.addChildViewController(mainNav);
        tabbar.addChildViewController(readNav);
        tabbar.addChildViewController(musicNav);
        tabbar.addChildViewController(movieNav);
        rootWindow.rootViewController = tabbar
    }
    
    
   static func customNav() -> Void {
        
        let bar : UINavigationBar = UINavigationBar();
        bar.barTintColor = UIColor.black;
        bar.tintColor = UIColor.white;
        bar.isTranslucent = false;
        bar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white];
        
        let textAttributes : NSDictionary = [NSFontAttributeName : UIFont.systemFont(ofSize: 15)];
        
        UIBarButtonItem.appearance().setTitleTextAttributes(textAttributes as? [String : Any], for: UIControlState(rawValue: UInt(0)));
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
    }
}
