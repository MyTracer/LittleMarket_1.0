//
//  AppDelegate.swift
//  LittleMarket
//
//  Created by J on 16/9/20.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

//    MARK: - 跳转
    func enterMainPage()  {
        // 获取主界面的故事版
        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
        print("进入主页窗口")
    }
//    MARK: - 系统
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        用户登录验证
        /*
         1.读取本地文件
         2.验证用户
         */
        UserInfo.shareUserInfo.loadUserInfoFormSandbox()
        if UserInfo.shareUserInfo.loginStatus! {
            // 判断用户名密码正确性（服务器）主页中判断
            // 已登录，进入主页
            self.enterMainPage()
        }else{
            print("进入登录窗口")
        }
        
        return true
    }
   
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
