//
//  Constant.swift
//  LittleMarket
//
//  Created by J on 16/9/20.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

let ScreenBounds = UIScreen.main.bounds
let ScreenWidth = ScreenBounds.width
let ScreenHeight = ScreenBounds.height

let BarHeight = UIApplication.shared.statusBarFrame.height

let Judge = OS.debug // 运行模式


enum OS{
    case test
    case debug
    case run
}

struct ArticleCagetory {
    static let categoryDict = [
        "archive": "历史精华",
        
    ]
}

struct CellReuseIdentifier {
    static let MyGrid = "MyGrid"
    static let FindGrid = "FindGrid"
    static let OtherGrid = "OtherGrid"
    
    static let UserInfo = "UserInfo"
    static let UserMenu = "UserMenu"
    static let UserGrid = "UserGrid"
    static let UserDetail = "UserDetail"
    
    
}

struct SegueId {
    static let PopoverSortOrderMenu = "PopoverSortOrderMenu"
    
}

struct API {
    static let APIHost = "http://192.168.1.101:3000/"
    static let UserAPI = API.APIHost + "users/"
    static let LoginAPI = API.UserAPI + "checkUser"
    static let FindUserAPI = API.UserAPI + "findUser"
    static let CheckUserAPI = API.UserAPI + "checkUserName"
    static let AddUserAPI = API.UserAPI + "addUser"
    static let EditUserAPI = API.UserAPI + "updateUser"
    
    
    
    static let ProductAPI = API.APIHost + "products/"
    static let UserGirdAPI = API.ProductAPI + "userProducts"
    static let OtherGirdAPI = API.ProductAPI + "sortProducts"
    static let DeleteGirdAPI = API.ProductAPI + "deleteProducts"
    static let AddGirdAPI = API.ProductAPI + "addProducts"
    
    
    static let SortAPI = API.APIHost + "sorts/"
    
    static let FindGirdAPI = API.APIHost + "Progress/GetRileiDetail"
    
}
