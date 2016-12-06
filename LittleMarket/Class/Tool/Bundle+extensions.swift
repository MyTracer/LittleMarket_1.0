//
//  Bundle+extensions.swift
//  LittleMarket
//
//  Created by J on 2016/12/6.
//  Copyright © 2016年 J. All rights reserved.
//

import Foundation
extension Bundle {
    var namespace:String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
