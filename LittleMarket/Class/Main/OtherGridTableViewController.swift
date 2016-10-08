//
//  OtherGridTableViewController.swift
//  LittleMarket
//
//  Created by J on 2016/9/23.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class OtherGridTableViewController: UITableViewController {

    //  MARK: - 变量
    // 定义行高
    let cellHeight:CGFloat = 144
    
    var sortidStr:String = ""
    // 行数
    var cellCount:Int = 0
    
    // 内容
    var error:String?
    var count:Int?
    var otherGrid:[OtherGridModel] = []
    
    //  MARK: - 网络请求
    func getData()  {
        // 登陆网络请求
        // 请求参数（密码加密后传输）
        let parameter:Dictionary = ["sortid":sortidStr]
        // 框架进行网络请求
        Alamofire.request(API.OtherGirdAPI, method: .get, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value)
                self.responseSuccess(response: response.result.value as! Dictionary)
                
            case .failure(let error):
                print(error)
                self.responseError()
            }
        }
        
    }
    // 访问失败
    func responseError() {
        print("访问失败")
        HUD.OnlyText(text: "加载失败")
    }
    // 访问成功
    func responseSuccess(response: [String:AnyObject]) {
        print("访问成功")
        
        // 判断数据是否正常
        if response["code"] as! String == "200" {
            for dict:NSDictionary in response["msg"] as! Array{
                let p = OtherGridModel.objectWithKeyValues(keyValues: dict) as! OtherGridModel
                
                self.otherGrid.insert(p, at: (self.otherGrid.count))
            }
            self.cellCount = self.otherGrid.count
            self.tableView.reloadData()
            
        }else{
            // 数据不正确
            print("返回数据有误")
        }
        
        HUD.dismiss()
    }
    
    //  MARK: - 系统
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = cellHeight
        // 加载数据
        self.getData()
        
        HUD.loadImage()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        HUD.dismiss()
    }
    
//     MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.cellCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.OtherGrid, for: indexPath) as! OtherGridTableViewCell
        
        let index = indexPath.section
        cell.bindModel(model: otherGrid[index], index: index)
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
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let answerControlelr = segue.destination as? GridDetailViewController, let index = tableView.indexPathForSelectedRow?.section {
            let answer = otherGrid[index]
            answerControlelr.useridStr = answer.sortid
            
        }
     }
     

}
