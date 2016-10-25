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
        let url = URL(string: imageUrl!)
        self.potoView?.kf.setImage(with: url,
                                   placeholder: UIImage.init(imageLiteralResourceName: "default_img"),
                                   options: [.transition(.fade(1))],
                                   progressBlock: nil,
                                   completionHandler: nil)
        
    }
    func initSubView(){
        let titleView = UILabel(frame: CGRect.init(x: 0, y: 0, width: 250, height: 64))
        titleView.backgroundColor = UIColor(red: 52/255, green: 222/255, blue: 136/255, alpha: 1).withAlphaComponent(0.8)
        titleView.textAlignment = NSTextAlignment.center
        titleView.text = "PeekView"
        self.view.addSubview(titleView)
        
        self.potoView = UIImageView(frame: CGRect.init(x: 0, y: 64, width: 250, height: 250-60))
        self.potoView?.contentMode = UIViewContentMode.scaleToFill
        self.view.addSubview(self.potoView!)
    }
    //pragma mark - 底部预览界面选项
    
//    func previewActionItems() -> [UIPreviewActionItem] {
//        //
//        let action1 = UIPreviewAction(title: "点赞", style: .default) { (action, previewViewController) in
//            //
//        }
//        let action2 = UIPreviewAction(title: "评论", style: .default) { (action, previewViewController) in
//            //
//        }
//        let action3 = UIPreviewAction(title: "嘿嘿", style: .default) { (action, previewViewController) in
//            //
//        }
//        let action4 = UIPreviewAction(title: "呵呵", style: .default) { (action, previewViewController) in
//            //
//        }
//        let actionItems = [action1,action2,action3,action4]
//        return actionItems
//        
//    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
