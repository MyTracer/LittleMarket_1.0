//
//  Post02ViewController.swift
//  LittleMarket
//
//  Created by J on 2016/10/10.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

class Post02ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
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
    
 
    
    @IBOutlet weak var pvSort: UIPickerView!
//    MARK: - 事件
    // 上传图片
    @IBAction func picUpdate(_ sender: UIButton) {
        /// 判断数据源是否合法，这里的.photoLibrary省略了其类名，Swift会自动推导
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            // 这一句，开始调用图库
            self.present(imagePicker,animated: true)
        }
    }
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            // 将图片显示给UIImageView
            // imagePicked.image = image
            
            let imageT = image.reSizeImage(reSize: Magic.reSize)
            //将选择的图片保存到Document目录下
            let fileManager = FileManager.default
            let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                               .userDomainMask, true)[0] as String
            let filePath = "\(rootPath)/pickedimage.JPG"
            let imageData = UIImageJPEGRepresentation(imageT, 1.0)
            fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
            
            //上传图片
            if (fileManager.fileExists(atPath: filePath)){
                //取得NSURL
                let imageNSURL:URL = URL.init(fileURLWithPath: filePath)
                
                

                
                //使用Alamofire上传
                
                Alamofire.upload(imageNSURL, to: URL.init(string: API.UploadPicAPI)!, method: .post).validate().responseJSON(completionHandler: { (response) in
                    switch response.result{
                    case .success(_):
                        print("请求成功")
                        self.picName(response: response.result.value as! Dictionary)
                    case .failure(let error):
                        print(error)
                        DispatchQueue.main.async(execute: {
                            self.HUDHide()
                            self.HUDtext(text: "请求失败")
                        })
                    }
                })
                
            }
        }else{
            print("pick image wrong")
            // 还没返回界面无法提示
        }
        
        
        // 收回图库选择界面
        self.dismiss(animated: true, completion: nil)
    }
    // 确认图片
    func picName(response:[String:AnyObject]) {
        if response["code"] as! String == "200" {
            if (response["image_url"] as!String).isEmpty {
                return
            }
            self.picStr = response["image_url"] as!String
            DispatchQueue.main.async(execute: {
                self.HUDHide()
                self.HUDtext(text: "上传成功")
            })
        }
    }
    // 提交
    @IBAction func step(_ sender: UIButton) {
        // 取消键盘
        self.view.endEditing(true)
        // 验证
        self.check()
    }
    func check() {
        // 为空
        
        
        if picStr.isEmpty {
            // HUD提示
            self.HUDtext(text: "请先上传图片")
            return
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
        // picStr = Pic
        sortidStr = sort.sortArray[self.pvSort.selectedRow(inComponent: 0)].sortid
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
        
        hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        hud?.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud?.contentColor = UIColor.init(colorLiteralRed: 0, green: 0.6, blue: 0.7, alpha: 1)
        
        Alamofire.request(API.AddGirdAPI, method: .post, parameters: parameter).responseJSON { (response) in
            switch response.result{
            case .success(_):
                print("请求成功")
                let response = response.result.value as! [String:AnyObject]
                if response["code"] as! String == "200"
                {
                    DispatchQueue.main.async(execute: {
                        self.HUDHide()
                        self.HUDtext(text: "发布成功")
                        let _ = self.navigationController?.popToRootViewController(animated: true)
                        return
                    })
                }else{
                    // 数据不正确
                    print("返回数据有误")
                    // HUD提示
                    DispatchQueue.main.async(execute: {
                        self.HUDHide()
                        self.HUDtext(text: "发布失败")
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
