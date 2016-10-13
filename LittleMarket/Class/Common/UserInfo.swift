//
//  UserInfo.swift
//  LittleMarket
//
//  Created by J on 16/9/20.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    // 预定义
    let UserKey:String = "username"
    let PwdKey = "password"
    let LoginStatusKey:String = "loginStatus"
    let UserIdKey:String = "userid"
    
    // 变量
    var username:String = "" // 登陆名
    var password:String = ""   // 密码
    var loginStatus:Bool = false  // 状态
    
    var userid:String = ""
    var name:String = ""
    var pic:String = ""
    var phone:String = ""
    var adress:String = ""
    var note:String = ""
    
    var score:String  = ""
    var grade:String  = ""
    var isuse:String  = ""
    
    
    // 单例
    static let shareUserInfo = UserInfo()
    
    // 保持数据到沙盒
    func saveUserInfoToSandbox() -> () {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(self.username, forKey: UserKey)
        defaults.set(self.password, forKey: PwdKey)
        defaults.set(self.loginStatus, forKey: LoginStatusKey)
        // 保存数据
        defaults.synchronize()
    }
    
    // 获取沙盒数据
    func loadUserInfoFormSandbox() -> () {
        let defaults:UserDefaults = UserDefaults.standard
        if defaults.object(forKey: UserKey) != nil && defaults.object(forKey: PwdKey) != nil  && defaults.object(forKey: LoginStatusKey) != nil
        {
            self.username = defaults.object(forKey: UserKey) as! String
            self.password = defaults.object(forKey: PwdKey) as! String
            self.loginStatus = defaults.object(forKey: LoginStatusKey) as! Bool
        }
    }
}
