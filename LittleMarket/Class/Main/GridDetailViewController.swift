//
//  GridDetailViewController.swift
//  LittleMarket
//
//  Created by J on 2016/9/25.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class GridDetailViewController: UIViewController {
    // MARK: - 变量
    @IBOutlet weak var avatarWidth: NSLayoutConstraint!
    @IBOutlet weak var avatarHeight: NSLayoutConstraint!
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // 定义行高
    let cellHeight:CGFloat = 100
    
    // 行数
    var cellCount:Int = 0
    
    // 内容
    var count:Int?
    
    
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

}
