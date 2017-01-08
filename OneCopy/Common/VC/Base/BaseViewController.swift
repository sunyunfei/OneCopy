//
//  BaseViewController.swift
//  OneCopy
//
//  Created by Mac on 16/10/8.
//  Copyright © 2016年 DJY. All rights reserved.
//

typealias ReturnCallBack = (UIViewController,AnyObject,String)->Void

import UIKit

protocol ReturnCallBackDelegate {
    
    func returnCallBack(vc:UIViewController,result:AnyObject,identifier:String) -> Void;
}

class BaseViewController: UIViewController {
    
    var returnCallBack : ReturnCallBack?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func addReturnCallBackBlock(callBack:@escaping ReturnCallBack) -> Void {
        
        self.returnCallBack = callBack;
    }
    
}
