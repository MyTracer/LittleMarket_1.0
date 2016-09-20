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
    let UserKey:String = "user"
    let PwdKey = "pwd"
    let LoginStatusKey:String = "loginStatus"
    let UserNameKey:String = "userName"
    
    // 变量
    var user:String?
    var pwd:String?
    var loginStatus:Bool?
    var usernName:String?
    
    // 单例
    static let shareUserInfo = UserInfo()
    
    // 保持数据到沙盒
    func saveUserInfoToSandbox() -> () {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(self.user, forKey: UserKey)
        defaults.set(self.pwd, forKey: PwdKey)
        defaults.set(self.loginStatus, forKey: LoginStatusKey)
        // 保存数据
        defaults.synchronize()
    }
    
    // 获取沙盒数据
    func loadUserInfoFormSandbox() -> () {
        let defaults:UserDefaults = UserDefaults.standard
        self.user = defaults.object(forKey: UserKey) as? String
        self.pwd = defaults.object(forKey: PwdKey) as? String
        self.loginStatus = defaults.object(forKey: LoginStatusKey) as? Bool
    }
}
