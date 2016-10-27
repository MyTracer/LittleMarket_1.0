//
//  GridDetailViewController.swift
//  LittleMarket
//
//  Created by J on 2016/9/25.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class GridDetailViewController: UIViewController ,UITableViewDelegate{
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
    
    var personInfo = PersonInfoModel()
    
    var useridStr:String = ""
    // 获取数据
    
    
    
//     懒加载
    lazy var userMenu: UserMenuTableViewCell = {
        let userMenu = self.tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.UserMenu) as! UserMenuTableViewCell
        userMenu.addMenuItemTarget()
        userMenu.delegate = self
        return userMenu
    }()
    
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
    lazy var userDetailDataSource: UserDetailDataSource = {
        let dataSource = UserDetailDataSource()
        dataSource.userInfo = self.personInfo
        return dataSource
    }()
    // 头像
    lazy var avatarMaxRadius: CGFloat = {
        return self.avatarHeight.constant
    }()
    
    lazy var avatarMaxCornerRadius: CGFloat = {
        return self.avaterImageView.cornerRadius
    }()

    
    
//    MARK: - 网络
    func getData()  {
        // 登陆网络请求
        // 请求参数
        let parameter:Dictionary = ["userid":useridStr]
        
        hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        hud?.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud?.contentColor = UIColor.init(colorLiteralRed: 0, green: 0.6, blue: 0.7, alpha: 1)
        
        // 框架进行网络请求
        Alamofire.request(API.UserGirdAPI, method: .get, parameters: parameter).responseJSON { (response) in
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
        DispatchQueue.main.async(execute: {
            self.HUDHide()
            self.HUDtext(text: "请求失败")
        })
    }
    // 访问成功
    func responseSuccess(response: [String:AnyObject]) {
        print("访问成功")
        // 判断数据是否正常
        if response["code"] as! String == "200" {
            for dict:NSDictionary in response["msg"] as! Array{
                let p = UsersGridModel.objectWithKeyValues(keyValues: dict) as! UsersGridModel
                
                self.userGrid.insert(p, at: (self.userGrid.count))
            }
            self.cellCount = self.userGrid.count
            print(userGrid)
            
            
            
        }else{
            // 数据不正确
            print("返回数据有误")
        }
        DispatchQueue.main.async(execute: {
            self.HUDHide()
            // 未刷新表格
            self.setHeader()
        })
        
        
        
        
    }
//    MARK: - 数据
    // 显示头部数据
    func setHeader() {
        
        // 显示数据 ...  必填项
        let parameter:Dictionary = ["userid":useridStr];
        
        hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        hud?.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud?.contentColor = UIColor.init(colorLiteralRed: 0, green: 0.6, blue: 0.7, alpha: 1)
        // 框架进行网络请求
        Alamofire.request(API.FindUserAPI, method: .get, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value)
                self.findUserWith(response: response.result.value as! Dictionary)
            case .failure(let error):
                print(error)
                
                DispatchQueue.main.async(execute: {
                    self.HUDHide()
                    self.HUDtext(text: "请求失败")
                })
            }
        }
        
        
        
        
        

        
        // 绑定数据源
        tableView.dataSource = userGridDataSource
        tableView.rowHeight = CGFloat(UserMenuItem.Grids.rawValue)
        tableView.reloadData()
    }
    func findUserWith(response:[String:AnyObject]){
        
        tableHeader.bindModel(username: "UserName", name: "name", note: "note")
        // 解析数据
        // 判断数据正确性
        if response["code"] as? String == "200" {
            for dic:NSDictionary in response["msg"] as! Array{
                // 解析
                // 解析
                
                
                personInfo.username = dic["username"] as! String
                personInfo.userid = dic["userid"] as! String
                personInfo.name = dic["name"] as! String
                personInfo.pic = dic["pic"] as! String
                personInfo.phone = dic["phone"] as! String
                personInfo.adress = dic["adress"] as! String
                personInfo.note = dic["note"] as! String
                personInfo.score =  dic["score"] as! String
                personInfo.grade = dic["grade"] as! String
                personInfo.isuse = dic["isuse"] as! String
                
                break
            }

            
            
            
            tableHeader.bindModel(username: personInfo.username, name: personInfo.name, note: personInfo.note)
            // 加载头像
            
            let url = URL(string: (API.APIHost + personInfo.pic))!
            self.avaterImageView.kf.setImage(with: url,
                                          placeholder: UIImage.init(imageLiteralResourceName: "default_img"),
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
            
        }else{
            // 数据不正确
            print("返回数据有误")
            
            
        }
        DispatchQueue.main.async(execute: {
            self.HUDHide()
        })
    }
    
//    MARK: - 系统
    var selectedIndexPath: NSIndexPath?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = selectedIndexPath {
            tableView.deselectRow(at: indexPath as IndexPath, animated: animated)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载头部，设置头部信息（读取UserInfo）在加载完数据之后。防止两次刷新重叠
        tableView.tableHeaderView = tableHeader
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 网络请求加载数据
        self.getData()
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



// MARK: - TableView Delegate

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return userMenu
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //头像随页面滑动改变大小
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let headerHeight = tableHeader.frame.height
        guard offsetY < headerHeight else {
            avatarHeight.constant = avatarMaxRadius/2
            avatarWidth.constant = avatarMaxRadius/2
            avaterImageView.cornerRadius = avatarMaxCornerRadius/2
            return
        }
        
        let multiplier = offsetY/headerHeight
        //外接矩形最终长宽都减一半
        avatarHeight.constant = avatarMaxRadius - avatarMaxRadius/2 * multiplier
        avatarWidth.constant = avatarHeight.constant
        layoutAvatarImmediately()
        //圆角半径最终减一半
        avaterImageView.cornerRadius = avatarMaxCornerRadius - avatarMaxCornerRadius/2 * multiplier
    }
    
    func layoutAvatarImmediately() {
        avatarHeight.isActive = true
        avatarWidth.isActive = true
    }
    
//     MRAK: - HUDTEXT
    var hud:MBProgressHUD?
    
    func HUDtext(text:String)  {
        
        hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        
        hud?.mode = MBProgressHUDMode.text
        hud?.label.text = NSLocalizedString(text, comment: "HUD message title")
        hud?.offset = CGPoint.init(x: 0, y: MBProgressMaxOffset)
        hud?.hide(animated: true, afterDelay: 3)
    }
    func HUDHide()  {
        hud?.hide(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 清空提示框
        self.HUDHide()
        
    }
    
}

// MARK: - UserMenuDelegate
extension GridDetailViewController: UserMenuDelegate {
    func selectMenuItem(item: UserMenuItem) {
        // guard userInfo != nil else { return }
        //........................................................................................//
        switch item {
        case .Grids:
            self.tableView.dataSource = userGridDataSource
            self.tableView.separatorStyle = .none
        case .User:
            self.tableView.dataSource = userDetailDataSource
            self.tableView.separatorStyle = .singleLine
        }
        self.tableView.rowHeight = CGFloat(item.rawValue)
        self.tableView.reloadData()
    }
}
