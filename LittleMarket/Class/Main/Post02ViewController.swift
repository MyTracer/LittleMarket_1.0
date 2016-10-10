//
//  Post02ViewController.swift
//  LittleMarket
//
//  Created by J on 2016/10/10.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class Post02ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
//    MARK: - 变量
    var nameStr:String = ""
    var priceStr:String = ""
    var noteStr:String = ""
    
    var productidStr:String = ""
    var dateStr:String = ""
    var picStr:String = ""
    var sortidStr:String = ""
    var useridStr:String = ""
    var scoreStr:String = ""
    var gradeStr:String = ""
    var isuseStr:String = ""
    
    let sort:SortInfo = SortInfo.shareSortInfo
    
    @IBOutlet weak var lbPic: UITextField!
    @IBOutlet weak var pvSort: UIPickerView!
//    MARK: - 事件
    // 提交
    @IBAction func step(_ sender: UIButton) {
        // 取消键盘
        self.view.endEditing(true)
        // 验证
        self.check()
    }
    func check() {
        // 为空
        var Pic = lbPic.text
        
        if Pic!.isEmpty {
            Pic = "- -"
        }
        
        let date = Date()
        let timeFormatter = DateFormatter()
        // timeFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm:ss.SSS"
        timeFormatter.dateFormat = "yyMMddHHmmss"
        let strNowTime = timeFormatter.string(from: date) as String
        
//        nameStr = nameStr
//        priceStr = priceStr
//        noteStr = noteStr
        productidStr = "P" + strNowTime
        dateStr = strNowTime
        picStr = Pic!
        sortidStr = sort.sortArray[self.pvSort.selectedRow(inComponent: 1)].sortid
        useridStr = UserInfo.shareUserInfo.userid
        scoreStr = "1"
        gradeStr = "1"
        isuseStr = "1"
        
        // 存入数据库
        self.upLoad()
    }
    
    func upLoad()  {
        let parameter:Dictionary = ["productid":productidStr,
                                    "name":nameStr,
                                    "note":noteStr,
                                    "date":dateStr,
                                    "price":priceStr,
                                    "pic":picStr,
                                    "sortid":sortidStr,
                                    "userid":useridStr,
                                    "score":scoreStr,
                                    "grade":gradeStr,
                                    "isuse":isuseStr];
        // 框架进行网络请求
        Alamofire.request(API.AddUserAPI, method: .post, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value)
                let response = response.result.value as! [String:AnyObject]
                if response["code"] as! String == "200"
                {
                    HUD.OnlyText(text: "发布成功")
                    let _ = self.navigationController?.popToRootViewController(animated: true)
                    return
                }
                
                
            case .failure(let error):
                print(error)
                
                // HUD提示
                HUD.OnlyText(text: "请确认信息")
            }
        }
    }

    
    // 取消键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        HUD.dismiss()
        self.view.endEditing(true)
    }
//    MARK: - 代理方法
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sort.sortArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sort.sortArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(sort.sortArray[row].sortid)
    }
    
//    MARK: - 系统
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 清空提示框
        HUD.dismiss()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pvSort.delegate = self
        self.pvSort.dataSource = self
        

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
