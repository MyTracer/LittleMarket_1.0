//
//  UserGridDataSource.swift
//  LittleMarket
//
//  Created by J on 2016/9/26.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class UserGridDataSource: NSObject ,UITableViewDataSource {
    
    var userGridList: [UsersGridModel] = []
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userGridList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.UserGrid, for: indexPath) as! UsersGridTableViewCell
        cell.bindModel(model: userGridList[indexPath.row])
        
        // Configure the cell...
        
        return cell
    }
}
