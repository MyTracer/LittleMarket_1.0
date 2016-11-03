//
//  Sign02ViewController.swift
//  LittleMarket
//
//  Created by J on 2016/10/9.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

import Alamofire

class Sign02ViewController: UIViewController {
//    MARK: - 变量
    @IBOutlet weak var lbName: UITextField!
    @IBOutlet weak var lbPhone: UITextField!
    @IBOutlet weak var lbAdress: UITextField!
    @IBOutlet weak var lbNote: UITextField!
    
    var usernameStr:String = ""
    var passwordStr:String = ""
    var useridStr:String = ""
    var nameStr:String = ""
    var picStr:String = ""
    var phoneStr:String = ""
    var adressStr:String = ""
    var noteStr:String = ""
    var scoreStr:String = ""
    var gradeStr:String = ""
    var isuseStr:String = ""
    
    
    
    
//    MARK: - 事件
    @IBAction func back(_ sender: UIButton) {
        
        self.view.endEditing(true)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func step(_ sender: UIButton) {
        // 取消键盘
        self.view.endEditing(true)
        // 验证
        self.check()
    }
//    MARK: - 函数
    // 验证
    func check() {
        // 为空
        let Name = lbName.text
        let Phone = lbPhone.text
        var Adress = lbAdress.text
        var Note = lbNote.text
        
        if Name!.isEmpty || Phone!.isEmpty{
            // HUD提示
            self.HUDtext(text: "请确认信息")
            return
        }
        if Adress!.isEmpty {
            Adress = "- -"
        }
        if Note!.isEmpty {
            Note = "- -"
        }
        
        if !Validate.nickname(Name!).isRight {
            self.HUDtext(text: "请确认姓名格式")
            return
        }
        
        if !Validate.phoneNum(Phone!).isRight {
            self.HUDtext(text: "请确认电话格式")
            return
        }
        
        let date = Date()
        let timeFormatter = DateFormatter()
        // timeFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm:ss.SSS"
        timeFormatter.dateFormat = "yyMMddHHmmss"
        let strNowTime = timeFormatter.string(from: date) as String
        
        // 填写数据
//        usernameStr = usernameStr
//        passwordStr = passwordStr
        useridStr = "U"+strNowTime
        nameStr = Name!
        picStr = "image/me.png"
        phoneStr = Phone!
        adressStr = Adress!
        noteStr = Note!
        scoreStr = "1"
        gradeStr = "1"
        isuseStr = "1"
        
        // 验证用户名是否存在
        self.userNameisUsed(UserNameStr: self.usernameStr)
        
        
    }
    func userNameisUsed(UserNameStr:String) {
        
        let parameter:Dictionary = ["username":UserNameStr];
        
        // 等待提示框
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud?.contentColor = UIColor.init(colorLiteralRed: 0, green: 0.6, blue: 0.7, alpha: 1)
        hud?.label.text = NSLocalizedString("Check", comment: "HUD loading title")
        
        // 框架进行网络请求
        Alamofire.request(API.CheckUserAPI, method: .get, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value!)
                let response = response.result.value as! [String:AnyObject]
                if response["isuse"] as! String == "1"
                {
                    DispatchQueue.main.async(execute: {
                        self.HUDHide()
                        self.HUDtext(text: "用户名已占用")
                        return
                    })
                    
                }
                // 存入数据库
                self.upLoad()
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
    
    func upLoad()  {
        let parameter:Dictionary = ["username":usernameStr,
                                    "userid":useridStr,
                                    "name":nameStr,
                                    "password":passwordStr,
                                    "pic":picStr,
                                    "phone":phoneStr,
                                    "adress":adressStr,
                                    "note":noteStr,
                                    "score":scoreStr,
                                    "grade":gradeStr,
                                    "isuse":isuseStr];
        // 框架进行网络请求
        Alamofire.request(API.AddUserAPI, method: .post, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                print(response.result.value!)
                let response = response.result.value as! [String:AnyObject]
                if response["code"] as! String == "200"
                {
                    DispatchQueue.main.async(execute: {
                        self.HUDHide()
                        self.HUDtext(text: "注册成功")
                        sleep(3)
                        let _ = self.navigationController?.popToRootViewController(animated: true)
                        return
                    })

                    
                }
                
                
            case .failure(let error):
                print(error)
                
                // HUD提示
                DispatchQueue.main.async(execute: {
                    self.HUDHide()
                    self.HUDtext(text: "注册失败")
                })
            }
        }
    }
    
    // 取消键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        HUD.dismiss()
        self.view.endEditing(true)
    }
//    MARK: - 系统
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    //     MRAK: - HUDTEXT
    var hud:MBProgressHUD?
    func HUDtext(text:String)  {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        
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
