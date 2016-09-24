//
//  NSObject-extension.swift
//  LittleMarket
//
//  Created by J on 2016/9/22.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

extension NSObject{
    class func objectWithKeyValues(keyValues:NSDictionary) -> AnyObject{
        let model = self.init()
        //存放属性的个数
        var outCount:UInt32 = 0
        //获取所有的属性
        let properties = class_copyPropertyList(self.classForCoder(), &outCount)
        //遍历属性
        for i in 0 ..< Int(outCount) {
            //获取第i个属性
            let property = properties?[i]
            //得到属性的名字
            let key = NSString(cString: property_getName(property), encoding: String.Encoding.utf8.rawValue)!
            if let value = keyValues[key]{
                //为model类赋值
                model.setValue(value, forKey: key as String)
            }
        }
        return model
    }
}
