//
//  Post01ViewController.swift
//  LittleMarket
//
//  Created by J on 2016/10/10.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class Post01ViewController: UIViewController {
//    MARK: - 变量
    let segueID = "Post02"
    
    @IBOutlet weak var lbName: UITextField!
    @IBOutlet weak var lbPrice: UITextField!
    @IBOutlet weak var lbNote: UITextView!
//    MARK: - 事件
    @IBAction func goNext(_ sender: UIButton) {
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
        let Price = lbPrice.text
        let Note = lbNote.text
        
        if Name!.isEmpty || Price!.isEmpty || Note!.isEmpty{
            // HUD提示
            self.HUDtext(text: "请确认信息")
            return
        }
        if !Validate.text(Name!).isRight {
            self.HUDtext(text: "请确认名称格式")
            return
        }
        if !Validate.numDe(Price!).isRight {
            self.HUDtext(text: "请确认价格格式")
            return
        }
        
        self.performSegue(withIdentifier:self.segueID, sender: nil)
        
    }
    // 取消键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        HUD.dismiss()
        self.view.endEditing(true)
    }
//    MARK: - 系统
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = true
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
            let controller = segue.destination as! Post02ViewController
            controller.nameStr = lbName.text!
            controller.priceStr = lbPrice.text!
            controller.noteStr = lbNote.text!
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
