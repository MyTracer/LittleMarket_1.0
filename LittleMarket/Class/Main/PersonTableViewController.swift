//
//  PersonTableViewController.swift
//  LittleMarket
//
//  Created by J on 16/9/21.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class PersonTableViewController: UITableViewController {
//  MARK: - 变量
    // 用户信息
    var userinfo:UserInfo = UserInfo.shareUserInfo
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbClass: UILabel!
    @IBOutlet weak var lbAdress: UILabel!
//  MARK: - 初始化
    func loadInfo()  {
        
        //            测试
        switch Judge {
        case .test:
            lbUserName.text = "用户名"
            lbName.text = "昵称"
            lbPhone.text = "电话"
            lbClass.text = "班级"
            lbAdress.text = "地址"
        case .debug:
            lbUserName.text = userinfo.username
            lbName.text = userinfo.name
            lbPhone.text = userinfo.phone
            lbClass.text = userinfo.note
            lbAdress.text = userinfo.adress
        case .run:
            break
            
        }

        
        
    }
//  MARK: - 退出
    
    @IBAction func loginOut(_ sender: AnyObject) {
        // 修改信息
        userinfo.loginStatus = false
        userinfo.saveUserInfoToSandbox()
        
        // 如有推送，修改推送信息
        
        // 跳转到登录界面
        self.enterLoginPage()
    }
//    MARK: - 跳转
    // 跳转至Login
    func enterLoginPage()  {
        self.dismiss(animated: false, completion: nil)
        // 获取登录的故事版
        let storyboard:UIStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
        self.view.window?.rootViewController = storyboard.instantiateInitialViewController()
        
    }
//  MARK: - 系统
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInfo()
        // All three of these calls are equivalent
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
