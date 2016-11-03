//
//  FindGridViewController.swift
//  LittleMarket
//
//  Created by J on 2016/9/23.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class FindGridViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource , UIViewControllerPreviewingDelegate{
    //  MARK: - 变量
    @IBOutlet weak var tvGrid: UITableView!
    
    var isCan3DTouch = true
    // Appdelegte
    let app = UIApplication.shared.delegate as! AppDelegate
    
    
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
        // 登陆网络请求
        // 框架进行网络请求
        Alamofire.request(API.SortAPI, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value!)
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
            self.tvGrid.dg_stopLoading()
        })
        
    }
    // 访问成功
    func responseSuccess(response: [String:AnyObject]) {
        print("访问成功")
        
        // 存储类别
        
        let sort:SortInfo = SortInfo.shareSortInfo
        
        // 移除
        sort.sortArray.removeAll()
        
        if response["code"] as! String == "200" {
            for dict:NSDictionary in response["msg"] as! Array{
                let p = FindGridModel.objectWithKeyValues(keyValues: dict) as! FindGridModel
                let s:Sort = Sort()
                s.name = dict["name"] as! String
                s.sortid = dict["sortid"] as! String
                
                sort.sortArray.insert(s, at: (self.findGrid.count))
                self.findGrid.insert(p, at: (self.findGrid.count))
            }
            self.cellCount = self.findGrid.count
            self.tvGrid.reloadData()
            
        }else{
            // 数据不正确
            print("返回数据有误")
        }
        DispatchQueue.main.async(execute: {
            self.HUDHide()
            self.tvGrid.dg_stopLoading()
        })
    
    }
    // 登陆请求
    func login() {
        // 登陆网络请求
        // 请求参数（密码加密后传输）
        let parameter:Dictionary = ["username":UserInfo.shareUserInfo.username,"password":UserInfo.shareUserInfo.password.md5!]
        
        hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        hud?.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud?.contentColor = UIColor.init(colorLiteralRed: 0, green: 0.6, blue: 0.7, alpha: 1)
        
        // 框架进行网络请求
        Alamofire.request(API.LoginAPI, method: .get, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value!)
                self.loginWith(response: response.result.value as! Dictionary)
            case .failure(let error):
                DispatchQueue.main.async(execute: {
                    self.HUDHide()
                    self.enterLoginPage()
                })
                print(error)
                
            }
        }
    }
    func loginWith(response:[String:AnyObject]){
        // 解析数据
        let userinfo:UserInfo = UserInfo.shareUserInfo
        // 判断数据正确性
        if response["code"] as! String == "200" {
            for dic:NSDictionary in response["msg"] as! Array{
                // 解析
                
                
                userinfo.loginStatus = true
                
                userinfo.userid = dic["userid"] as! String
                userinfo.name = dic["name"] as! String
                userinfo.pic = dic["pic"] as! String
                userinfo.phone = dic["phone"] as! String
                userinfo.adress = dic["adress"] as! String
                userinfo.note = dic["note"] as! String
                userinfo.score =  dic["score"] as! String
                userinfo.grade = dic["grade"] as! String
                userinfo.isuse = dic["isuse"] as! String
                break
            }

            
            print(userinfo)
            
            if !userinfo.userid.isEmpty {
                // 用户存在，数据正常
                // 必要信息持久化
                userinfo.saveUserInfoToSandbox()
                DispatchQueue.main.async(execute: {
                    // 返回主线程
                    // 刷新UI，并切换界面
                    self.reloadGO()
                })
                return
            }
        }
        // 数据不正确
        print("返回数据有误")
        DispatchQueue.main.async(execute: {
            self.HUDHide()
            self.enterLoginPage()
        })
        
        
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
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            
            self.isCan3DTouch = true
        }
        else {
            self.isCan3DTouch = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 登陆成功后自动加载数据
        self.login()
    }
    
    override func loadView() {
        super.loadView()
        // 修饰
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0)
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        self.tvGrid.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                
                self?.reloadGO()
                
                // 移除视图，应该在网络请求处理完成之后
                // self?.tableView.dg_stopLoading()
                
            })
            }, loadingView: loadingView)
        self.tvGrid.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        self.tvGrid.dg_setPullToRefreshBackgroundColor(self.tvGrid.backgroundColor!)
        
    }
    deinit {
        self.tvGrid?.dg_removePullToRefresh()
    }
    func reloadGO()  {
        // 清除原有数据
        findGrid = []
        cellCount = 0
        
        // 加载
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if self.isCan3DTouch{
            registerForPreviewing(with: self, sourceView: cell.contentView)
        }
        
        let index = indexPath.section
        cell.bindModel(model: findGrid[index], index: index)
        // Configure the cell...
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //    MARK: - 3Dtouch代理方法
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let indexPath = self.tvGrid.indexPath(for: previewingContext.sourceView.superview as! UITableViewCell)
        let dic = findGrid[indexPath!.section]
        let peekVC = DTouchViewController.init(imgUrl: dic.pic)
        return peekVC
    }
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
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

