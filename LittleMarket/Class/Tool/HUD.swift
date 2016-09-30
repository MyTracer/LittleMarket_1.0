//
//  HUD.swift
//  LittleMarket
//
//  Created by J on 2016/9/30.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class HUD: NSObject {
    //    MARK：- HUD
    public static func loadImage() {
        
        var images = Array<UIImage>()
        
        for i in 1...31 {
            
            let patch =  Bundle.main.path(forResource: "load_\(i)@2x.png", ofType: nil, inDirectory: nil)
            let image = UIImage(contentsOfFile: patch!)
            images.append(image!)
        }
        SJProgressHUD.showWaitingWithImages(images)
    }
    public static func Waiting() {
        SJProgressHUD.showWaiting("正在加载中......")
    }
    public static func Success() {
        SJProgressHUD.showSuccess()
    }
    public static func Error() {
        SJProgressHUD.showError()
    }
    public static func Info() {
        SJProgressHUD.showInfo()
    }
    public static func OnlyText(text:String) {
        SJProgressHUD.dismiss()
        SJProgressHUD.showOnlyText(text)
    }
    public static func statusBar() {
        SJProgressHUD.showStatusBarWithText()
    }
    public static func dismiss() {
        SJProgressHUD.dismiss()
    }
}
