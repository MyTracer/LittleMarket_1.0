//
//  OtherGridTableViewController.swift
//  LittleMarket
//
//  Created by J on 2016/9/23.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class OtherGridTableViewController: UITableViewController, UIViewControllerPreviewingDelegate {

    //  MARK: - 变量
    var isCan3DTouch = true
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
        
        hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        hud?.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud?.contentColor = UIColor.init(colorLiteralRed: 0, green: 0.6, blue: 0.7, alpha: 1)
        // 框架进行网络请求
        Alamofire.request(API.OtherGirdAPI, method: .get, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
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
            self.tableView.dg_stopLoading()
        })
    }
    // 访问成功
    func responseSuccess(response: [String:AnyObject]) {
        print("访问成功")
        
        // 判断数据是否正常
        if response["code"] as! String == "200" {
            for dict:NSDictionary in response["msg"] as! Array{
                let p = OtherGridModel.objectWithKeyValues(keyValues: dict) as! OtherGridModel
                // 测试- 过多数据问题
                // FIXME: - 数据缓存
                self.otherGrid.insert(p, at: (self.otherGrid.count))
                
            }
            self.cellCount = self.otherGrid.count
            
            self.tableView.reloadData()
            
        }else{
            // 数据不正确
            print("返回数据有误")
        }
        
        DispatchQueue.main.async(execute: {
            self.HUDHide()
            self.tableView.dg_stopLoading()
        })
    }
    //  MARK: - 编辑
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //  覆盖后会失效
        if editingStyle == UITableViewCellEditingStyle.delete {
            
        }
        if editingStyle == UITableViewCellEditingStyle.insert {
            
        }
    }
    // 重写后，会覆盖commit editingStyle的方法
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //
        var judge:Int = 0
        let deleteRoWAction:UITableViewRowAction = UITableViewRowAction.init(style: .default, title: "举报", handler: {(UITableViewRowAction, IndexPath) -> Void in
            print("举报")
            judge = -1
            self.judgePath(judge: judge, indexPath: IndexPath)
            })
        let addRowAction:UITableViewRowAction = UITableViewRowAction.init(style: .destructive, title: "喜爱", handler:{(UITableViewRowAction, IndexPath) -> Void in
            judge = 1
            self.judgePath(judge: judge, indexPath: IndexPath)
            print("喜爱")
        })
        deleteRoWAction.backgroundColor = UIColor.red
        addRowAction.backgroundColor = UIColor.blue
        return [deleteRoWAction,addRowAction]
    }
    
    func judgePath(judge:Int, indexPath: IndexPath)  {
        // 网络请求
        // 请求参数
        var score:String = self.otherGrid[indexPath.section].score
        score = "\(Int.init(score)! + judge)"
        let parameter:Dictionary = ["productid":self.otherGrid[indexPath.section].productid,"score":score]
        
        hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        hud?.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud?.contentColor = UIColor.init(colorLiteralRed: 0, green: 0.6, blue: 0.7, alpha: 1)
        // 框架进行网络请求
        Alamofire.request(API.JudgeGirdAPI, method: .post, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                var response = response.result.value as! [String:AnyObject]
                if response["code"] as! String == "200" {
                    
                    DispatchQueue.main.async(execute: {
                        // 返回主线程
                        // 刷新UI，并切换界面
                        self.HUDHide()
                        // 提示
                        self.HUDtext(text: "操作成功")
                        
                        self.otherGrid[indexPath.section].score = score
                        
                    })
                }else{
                    // 数据不正确
                    print("返回数据有误")
                    // HUD提示
                    DispatchQueue.main.async(execute: {
                        self.HUDHide()
                        self.HUDtext(text: "操作失败")
                    })
                }
                
                
            case .failure(let error):
                
                print(error)
                // HUD提示
                DispatchQueue.main.async(execute: {
                    self.HUDHide()
                    self.HUDtext(text: "请求失败")
                })
            }
        }
        
    }
    
    //  MARK: - 系统
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = cellHeight
        
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            
            self.isCan3DTouch = true
        }
        else {
            self.isCan3DTouch = false
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadGO()
    }
    
    //   MARK: -  下拉刷新
    override func loadView() {
        super.loadView()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0)
        
        
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                
                self?.reloadGO()
                
                // 移除视图，应该在网络请求处理完成之后
                // self?.tableView.dg_stopLoading()
                
            })
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
    
    deinit {
        tableView?.dg_removePullToRefresh()
    }
    func reloadGO()  {
        // 清除原有数据
        otherGrid = []
        cellCount = 0
        
        // 加载
        self.getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if self.isCan3DTouch{
            registerForPreviewing(with: self, sourceView: cell.contentView)
        }
        
        let index = indexPath.section
        cell.bindModel(model: otherGrid[index], index: index)
        // Configure the cell...
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //    MARK: - 3Dtouch代理方法
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let indexPath = self.tableView.indexPath(for: previewingContext.sourceView.superview as! UITableViewCell)
        let dic = otherGrid[indexPath!.section]
        let peekVC = DTouchViewController.init(imgUrl: dic.pic)
        return peekVC
    }
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
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
            answerControlelr.useridStr = answer.userid
            
        }
     }
//     MRAK: - HUDTEXT
    var hud:MBProgressHUD?
    
    func HUDtext(text:String)  {
        
        hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        
        hud?.mode = MBProgressHUDMode.text
        hud?.label.text = NSLocalizedString(text, comment: "HUD message title")
        hud?.offset = CGPoint.init(x: 0, y: MBProgressMaxOffset)
        hud?.hide(animated: true, afterDelay: 2)
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
