//
//  DTouchViewController.swift
//  LittleMarket
//
//  Created by J on 2016/10/25.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Kingfisher
class DTouchViewController: UIViewController {

    var etag:String?
    var potoView:UIImageView?
    var imageUrl:String?
    init(imgUrl:String){
        super.init(nibName: nil, bundle: nil)
        self.imageUrl = imgUrl
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.initSubView()
        self.initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initData()
    {
        if let url = URL(string: (API.APIHost + self.imageUrl!)){
            self.potoView?.kf.setImage(with: url,
                                       placeholder: UIImage.init(imageLiteralResourceName: "default_img"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
        }
        
        
    }
    func initSubView(){
        let titleView = UILabel(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        titleView.backgroundColor = UIColor(red: 52/255, green: 222/255, blue: 136/255, alpha: 1).withAlphaComponent(0.8)
        titleView.textAlignment = NSTextAlignment.center
        titleView.text = "More Detail"
//        self.view.addSubview(titleView)
        self.potoView = UIImageView(frame: CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-60))
     
        
        self.potoView?.contentMode = UIViewContentMode.scaleToFill
        self.view.addSubview(self.potoView!)
    }
    //pragma mark - 底部预览界面选项
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
