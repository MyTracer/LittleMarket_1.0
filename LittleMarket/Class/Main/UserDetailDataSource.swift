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
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.UserDetail, for: indexPath) as! UserDetailTableViewCell
        cell.bindModel(title: "1", detail: "2")
        
        // Configure the cell...
        
        return cell
    }
}
