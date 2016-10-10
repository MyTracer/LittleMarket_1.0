//
//  SortInfo.swift
//  LittleMarket
//
//  Created by J on 2016/10/10.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class SortInfo: NSObject {
    // 单例
    var sortArray:[Sort] = []
    
    static let shareSortInfo = SortInfo()
}
class Sort: NSObject {
    var sortid:String = ""
    var name:String = ""
}
