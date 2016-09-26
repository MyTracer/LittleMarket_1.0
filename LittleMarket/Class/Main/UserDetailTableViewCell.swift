//
//  UserDetailTableViewCell.swift
//  LittleMarket
//
//  Created by J on 2016/9/26.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDetail: UILabel!
    
    func bindModel(title:String ,detail:String)  {
        lbTitle.text = title
        lbDetail.text = detail
    }

}
