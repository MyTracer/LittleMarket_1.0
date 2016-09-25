//
//  LoginViewController.swift
//  LittleMarket
//
//  Created by J on 2016/9/21.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
//    MARK: - 变量
    var userStr:String?
    // 用户名
    var pwdStr:String?
    // 密码
    @IBOutlet weak var loginName: UITextField!
    @IBOutlet weak var loginPwd: UITextField!
    
//    MARK: - 登陆
    
    // 登陆事件
    @IBAction func loginClick(_ sender: UIButton) {
        // 退出编辑
        self.view.endEditing(true)
        // 获取参数（未去空）
        userStr = loginName.text!
        pwdStr = loginPwd.text!
        if (userStr!.isEmpty || pwdStr!.isEmpty)
        {
            // 存在未填写项
            print("登录信息不完整")
        }else
        {
            // 数据验证通过
            
            self.login()
        }
        // 初始判断
        print(userStr!,pwdStr!.md5)
    }
    // 登陆请求
    func login() {
        // 登陆网络请求
        // 请求参数（密码加密后传输）
        let parameter:Dictionary = ["lgn":userStr!,"pwd":pwdStr!.md5!];
        print(parameter)
        // 框架进行网络请求
        Alamofire.request(API.LoginAPI, method: .get, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value)
                self.loginWith(response: response.result.value as! Dictionary)
            case .failure(let error):
                print(error)
            }
        }
    }
    func loginWith(response:[String:String]){
        // 解析数据
        // 判断数据正确性
        if response["userId"]!.isEmpty {
            // 数据不正确
            print("返回数据有误")
        }else{
            // 解析
            let userinfo:UserInfo = UserInfo.shareUserInfo
            userinfo.user = userStr
            userinfo.pwd = pwdStr
            userinfo.loginStatus = true
            
            userinfo.userId = response["userId"]
            userinfo.userName = response["userName"]
            userinfo.departName = response["departName"]
            userinfo.dutyName = response["dutyName"]
            userinfo.cellPhone = response["cellPhone"]
            userinfo.roleName = response["roleName"]
            if !userinfo.userId!.isEmpty {
                // 用户存在，数据正常
                // 必要信息持久化
                userinfo.saveUserInfoToSandbox()
                DispatchQueue.main.async(execute: { 
                    // 返回主线程
                    // 刷新UI，并切换界面
                    self.enterMainPage()
                })
                
            
            }
        }
    }
    // 取消事件
    @IBAction func cancelClick(_ sender: UIButton) {
        // 退出编辑
        self.view.endEditing(true)
        // 清空内容
        loginName.text = ""
        loginPwd.text = ""
    }
//    MARK: - 跳转
    // 跳转至Main
    func enterMainPage()  {
        self.dismiss(animated: false, completion: nil)
        // 获取主界面的故事版
        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        self.view.window?.rootViewController = storyboard.instantiateInitialViewController()
        
    }
//    MARK: - 系统
    // 加载
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // 滑动
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        // 退出编辑模式
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}