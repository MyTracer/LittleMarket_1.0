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
        lbUserName.text = username
        lbName.text = name
        lbNote.text = note
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
