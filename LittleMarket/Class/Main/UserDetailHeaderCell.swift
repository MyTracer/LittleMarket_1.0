//
//  UserDetailHeaderCell.swift
//  LittleMarket
//
//  Created by J on 2016/9/25.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class UserDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbNote: UILabel!
    
    // 绑定数据
    func bindModel(username: String, name: String, note:String) {
        //            测试
        switch Judge {
        case .test:
            lbUserName.text = "用户名"
            lbName.text = "昵称"
            lbNote.text = "用户备注：行走的力量"
        case .debug:
            lbUserName.text = username
            lbName.text = name
            lbNote.text = note
            
        case .run:
            break
            
        }
     
    }

}
