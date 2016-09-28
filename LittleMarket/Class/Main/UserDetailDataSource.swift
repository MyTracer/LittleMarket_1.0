//
//  UserDetailDataSource.swift
//  LittleMarket
//
//  Created by J on 2016/9/26.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class UserDetailDataSource: NSObject ,UITableViewDataSource {
    
    
    var userDetail:[UserDetailModel] = []
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.UserDetail, for: indexPath) as! UserDetailTableViewCell
        switch indexPath.row {
        case 1:
            cell.bindModel(title: "用户名", detail: "Joke")
        case 2:
            cell.bindModel(title: "昵称", detail: "J")
        case 3:
            cell.bindModel(title: "联系方式", detail: "未知")
        case 4:
            cell.bindModel(title: "班级", detail: "1111")
        case 5:
            cell.bindModel(title: "信用度", detail: "AAA")
        default:
            break
        }
        
        // Configure the cell...
        
        return cell
    }
}
