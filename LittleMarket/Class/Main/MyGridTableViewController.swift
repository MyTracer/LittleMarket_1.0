//
//  MyGridTableViewController.swift
//  LittleMarket
//
//  Created by J on 2016/9/22.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class MyGridTableViewController: UITableViewController {
//  MARK: - 变量
    // 定义行高
    let cellHeight:CGFloat = 144
    
    
    // 行数
    var cellCount:Int = 0
    
    // 内容
    var error:String?
    var count:Int?
    var myGrid:[MyGridModel] = []
    
//  MARK: - 网络请求
    func getData()  {
        // 登陆网络请求
        // 请求参数（密码加密后传输）
         let parameter:Dictionary = ["date":"20160921","id":"02020003"]
        // 框架进行网络请求
        Alamofire.request(API.MyGirdAPI, method: .get, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value)
                self.responseSuccess(responseObj: response.result.value as! Array)
                
            case .failure(let error):
                print(error)
                self.responseError()
            }
        }

    }
    // 访问失败
    func responseError() {
        print("访问失败")
    }
    // 访问成功
    func responseSuccess(responseObj: [AnyObject]) {
        print("访问成功")
        // 判断数据是否正常
        for dict:NSDictionary in responseObj as! Array{
            let p = MyGridModel.objectWithKeyValues(keyValues: dict) as! MyGridModel
            
            self.myGrid.insert(p, at: (self.myGrid.count))
        }
        self.cellCount = self.myGrid.count
        print(myGrid)
        self.tableView.reloadData()
    }

//  MARK: - 系统
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = cellHeight
        
        // 加载数据
        self.getData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.cellCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.MyGrid, for: indexPath) as! MyGridTableViewCell
        
        let index = indexPath.section
        cell.bindModel(model: myGrid[index], index: index)
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
