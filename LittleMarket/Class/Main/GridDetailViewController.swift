//
//  GridDetailViewController.swift
//  LittleMarket
//
//  Created by J on 2016/9/25.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class GridDetailViewController: UIViewController {
//    MARK: - 变量
    @IBOutlet weak var avatarWidth: NSLayoutConstraint!
    @IBOutlet weak var avatarHeight: NSLayoutConstraint!
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // 定义行高
    let cellHeight:CGFloat = 100
    
    // 行数
    var cellCount:Int = 0
    
    // 内容
    var count:Int?
    var userGrid: [UsersGridModel] = []
    // 获取数据
    let userInfo:UserInfo = UserInfo.shareUserInfo
    
    
//     懒加载
    
    // tableview 头部
    lazy var tableHeader: UserDetailHeaderCell = {
        let header = self.tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.UserInfo) as! UserDetailHeaderCell
        return header
    }()
    // 数据源
    lazy var userGridDataSource: UserGridDataSource? = {
        let dataSource = UserGridDataSource()
        dataSource.userGridList = self.userGrid
        return dataSource
    }()
//    MARK: - 网络
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
            let p = UsersGridModel.objectWithKeyValues(keyValues: dict) as! UsersGridModel
            
            self.userGrid.insert(p, at: (self.userGrid.count))
        }
        self.cellCount = self.userGrid.count
        print(userGrid)
        
        // 未刷新表格
        self.setHeader()
        
        
    }
//    MARK: - 数据
    // 显示头部数据
    func setHeader() {
        
        // 显示数据 ...  必填项
        
        tableHeader.bindModel(username: userInfo.userName!, name: userInfo.user!, note: userInfo.roleName!)
        // 加载头像
        Alamofire.request("https://httpbin.org/image/png").responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.avaterImageView.image = image
            }
        }

        
        // 绑定数据源
        tableView.dataSource = userGridDataSource
        tableView.rowHeight = CGFloat(UserMenuItem.Grids.rawValue)
        tableView.reloadData()
    }
    
//    MARK: - 系统
    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载头部，设置头部信息（读取UserInfo）在加载完数据之后。防止两次刷新重叠
        tableView.tableHeaderView = tableHeader
        // 网络请求加载数据
        self.getData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
