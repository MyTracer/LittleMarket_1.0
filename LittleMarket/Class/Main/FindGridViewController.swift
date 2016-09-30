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
        // 登陆网络请求
        // 请求参数（密码加密后传输）
        let parameter:Dictionary = ["date":"20160921","id":"02020003"]
        // 框架进行网络请求
        Alamofire.request(API.FindGirdAPI, method: .get, parameters: parameter).responseJSON { (response) in
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
        HUD.OnlyText(text: "加载失败")
    }
    // 访问成功
    func responseSuccess(responseObj: [AnyObject]) {
        print("访问成功")
        // 判断数据是否正常
        for dict:NSDictionary in responseObj as! Array{
            let p = FindGridModel.objectWithKeyValues(keyValues: dict) as! FindGridModel
            
            self.findGrid.insert(p, at: (self.findGrid.count))
        }
        self.cellCount = self.findGrid.count
        print(findGrid)
        self.tvGrid.reloadData()
        HUD.dismiss()
        
    }
    
    //  MARK: - 系统
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvGrid.delegate = self
        self.tvGrid.rowHeight = cellHeight
        
        // 加载数据
        self.getData()
        
        HUD.loadImage()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
