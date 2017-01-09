//
//  LoginViewController.swift
//  loginDemo
//
//  Created by 孙云飞 on 2017/1/9.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameView: UIView!//账号底部视图
    @IBOutlet weak var userPasswordView: UIView!//密码底部视图
    @IBOutlet weak var registerBtn: UIButton!//注册按钮
    @IBOutlet weak var loginBtn: UIButton!//登录按钮
    @IBOutlet weak var userNameField: UITextField!//账号输入
    @IBOutlet weak var userPasswordField: UITextField!//密码输入
    @IBOutlet weak var welcomeLabel: UILabel!//欢迎label
    override func viewDidLoad() {
        super.viewDidLoad()
        
        p_setUI()
        //位置移动
        originMovePosition()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        //隐藏导航栏
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        //显示导航栏
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //UI的设置操作
    func p_setUI(){
    
        self.p_setField(bgView: userNameView, field: userNameField, str: "请输入账号")
        self.p_setField(bgView: userPasswordView, field: userPasswordField, str: "请输入密码")
        //注册按钮设置
        registerBtn.layer.cornerRadius = 5;
        registerBtn.layer.masksToBounds = true
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.borderColor = UIColor.white.cgColor
        //登录按钮设置
        loginBtn.layer.cornerRadius = 10;
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.white.cgColor
        //改变输入框光标颜色
        UITextField.appearance().tintColor = UIColor.white
    }
    
    //输入框的一些设置
    func p_setField(bgView:UIView,field:UITextField,str:NSString){
    
        //输入底部视图设置
        bgView.layer.cornerRadius = 20
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.white.cgColor
        //输入框的设置
        let placeholder:NSMutableAttributedString = NSMutableAttributedString.init(string: str as String)
        placeholder.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange.init(location: 0, length: str.length))
        field.attributedPlaceholder = placeholder
    }
    
    //动画设置
    //移动到位置
    func originMovePosition(){
    
        userNameView.transform = CGAffineTransform.init(translationX: -200, y: 0)
        userPasswordView.transform = CGAffineTransform.init(translationX: 200, y: 0)
        registerBtn.alpha = 0.0
        loginBtn.alpha = 0.0
        welcomeLabel.alpha = 0.0
        //开始动画
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {()-> Void in
        
            self.userNameView.transform = CGAffineTransform.identity
            self.userPasswordView.transform = CGAffineTransform.identity
        }, completion: {(finish:Bool)->Void in
        
            if finish{
            
                UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseIn, animations: {()-> Void in
                
                    self.registerBtn.alpha = 1.0
                    self.loginBtn.alpha = 1.0
                }, completion: nil)
                UIView.animate(withDuration: 3.0, animations: {()->Void in
                
                    self.welcomeLabel.alpha = 1.0;
                })
            }
        })
    }
    
    //点击注册按钮事件
    @IBAction func clickRegisterBtn(_ sender: UIButton) {
    }
    //点击登录按钮事件
    @IBAction func clickLoginBtn(_ sender: UIButton) {
        
        let rootWindow:UIWindow = UIApplication.shared.keyWindow!
        MainViewManager.createApp(rootWindow: rootWindow)
    }

}
