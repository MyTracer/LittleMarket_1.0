//
//  Sign01ViewController.swift
//  LittleMarket
//
//  Created by J on 2016/10/9.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class Sign01ViewController: UIViewController {
//    MARK: - 变量
    let segueID = "Sign02"
    
    @IBOutlet weak var lbUserName: UITextField!
    @IBOutlet weak var lbPWD01: UITextField!
    @IBOutlet weak var lbPWD02: UITextField!
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
        let UserName = lbUserName.text
        let PWD01 = lbPWD01.text
        let PWD02 = lbPWD02.text
        
        if UserName!.isEmpty || PWD01!.isEmpty || PWD02!.isEmpty{
            // HUD提示
            self.HUDtext(text: "请确认信息")
            return
        }
        
        if PWD01 != PWD02 {
            self.HUDtext(text: "两次密码输入不一致")
            return
        }
        
        if !Validate.username(lbUserName.text!).isRight {
            self.HUDtext(text: "用户名输入不规范")
            return
        }
        
        if !Validate.password(lbPWD01.text!).isRight {
            self.HUDtext(text: "密码输入不规范")
            return
        }
        
        // 验证用户名是否存在
        self.userNameisUsed(UserNameStr: UserName!)
        
        
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
                // 进入下一页
                self.performSegue(withIdentifier:self.segueID, sender: nil)
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == segueID{
            let controller = segue.destination as! Sign02ViewController
            controller.usernameStr = lbUserName.text!
            controller.passwordStr = lbPWD01.text!.md5
        }
    }
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
