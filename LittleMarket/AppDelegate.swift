//
//  AppDelegate.swift
//  LittleMarket
//
//  Created by J on 16/9/20.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var managr:NetworkReachabilityManager?
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
        // 检查网络
        self.managr = NetworkReachabilityManager(host: API.APIHost)
        self.managr?.listener = { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
                print("无法连接")
            }
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.unknown{
                print("未知网络")
            }
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi){
                print("3G`WIFI")
            }
            
            print("Network Status Changes:\(status)")
        }
        self.managr?.startListening()
        
//        用户登录验证
        /*
         1.读取本地文件
         2.验证用户
         */
        UserInfo.shareUserInfo.loadUserInfoFormSandbox()
        
        if UserInfo.shareUserInfo.loginStatus == false{
            return true
        }
        if UserInfo.shareUserInfo.loginStatus {
            // 判断用户名密码正确性（服务器）主页中判断
            // 已登录，进入主页
            self.enterMainPage()
        }else{
            print("进入登录窗口")
        }
        self.configShortCutItems()
        
        return true
    }
//    MARK: - 3Dtouch
    func configShortCutItems() {
        // 动态添加
        let icon1 = UIApplicationShortcutIcon.init(type: .share)
        let item1 = UIMutableApplicationShortcutItem.init(type: "share", localizedTitle: "分享", localizedSubtitle: nil, icon: icon1, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [item1]
    }
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "share":
            print("share click")
        default:
            print("shortcutItem")
        }
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

