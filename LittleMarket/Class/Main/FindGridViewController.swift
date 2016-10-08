//
//  FindGridViewController.swift
//  LittleMarket
//
//  Created by J on 2016/9/23.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class FindGridViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    //  MARK: - 变量
    @IBOutlet weak var tvGrid: UITableView!
    
    // 定义行高
    let cellHeight:CGFloat = 96
    
    
    // 行数
    var cellCount:Int = 0
    
    // 内容
    var error:String?
    var count:Int?
    var findGrid:[FindGridModel] = []
    
    //  MARK: - 网络请求
    func getData()  {
        HUD.loadImage()
        // 登陆网络请求
        // 框架进行网络请求
        Alamofire.request(API.SortAPI, method: .get, parameters: nil).responseJSON { (response) in
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
        
        if response["code"] as! String == "200" {
            for dict:NSDictionary in response["msg"] as! Array{
                let p = FindGridModel.objectWithKeyValues(keyValues: dict) as! FindGridModel
                
                self.findGrid.insert(p, at: (self.findGrid.count))
            }
            self.cellCount = self.findGrid.count
            self.tvGrid.reloadData()
            
        }else{
            // 数据不正确
            print("返回数据有误")
        }
        HUD.dismiss()
    
    }
    // 登陆请求
    func login() {
        // 登陆网络请求
        // 请求参数（密码加密后传输）
        let parameter:Dictionary = ["username":UserInfo.shareUserInfo.username,"password":UserInfo.shareUserInfo.password.md5!]
        
        // 框架进行网络请求
        Alamofire.request(API.LoginAPI, method: .get, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value)
                self.loginWith(response: response.result.value as! Dictionary)
            case .failure(let error):
                print(error)
                self.enterLoginPage()
            }
        }
    }
    func loginWith(response:[String:AnyObject]){
        // 解析数据
        // 判断数据正确性
        if response["code"] as! String == "200" {
            var dic:Dictionary = response["msg"]![0] as! [String:AnyObject]
            // 解析
            let userinfo:UserInfo = UserInfo.shareUserInfo
            
            userinfo.userid = dic["userid"] as! String
            userinfo.name = dic["name"] as! String
            userinfo.pic = dic["pic"] as! String
            userinfo.phone = dic["phone"] as! String
            userinfo.adress = dic["adress"] as! String
            userinfo.note = dic["note"] as! String
            userinfo.score =  dic["score"] as! String
            userinfo.grade = dic["grade"] as! String
            userinfo.isuse = dic["isuse"] as! String
            
            print(userinfo)
            
            if !userinfo.userid.isEmpty {
                // 用户存在，数据正常
                // 必要信息持久化
                userinfo.saveUserInfoToSandbox()
                DispatchQueue.main.async(execute: {
                    // 返回主线程
                    // 刷新UI，并切换界面
                    self.getData()
                })
            }
        }else{
            // 数据不正确
            print("返回数据有误")
            
            self.enterLoginPage()
            
        }
    }
    //    MARK: - 跳转
    // 跳转至Login
    func enterLoginPage()  {
        self.dismiss(animated: false, completion: nil)
        // 获取主界面的故事版
        let storyboard:UIStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
        self.view.window?.rootViewController = storyboard.instantiateInitialViewController()
        
    }
    //  MARK: - 系统
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvGrid.delegate = self
        self.tvGrid.rowHeight = cellHeight
        
        // 登陆成功后自动加载数据
        self.login()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        HUD.dismiss()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let answerControlelr = segue.destination as? OtherGridTableViewController, let index = tvGrid.indexPathForSelectedRow?.section {
            let answer = findGrid[index]
            answerControlelr.sortidStr = answer.sortid
            
        }
    }
 
    // MARK: - Table view data source
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.cellCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.FindGrid, for: indexPath) as! FindGridTableViewCell
        
        let index = indexPath.section
        cell.bindModel(model: findGrid[index], index: index)
        // Configure the cell...
        
        return cell
    }

}
