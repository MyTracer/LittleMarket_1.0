//
//  Sign00ViewController.swift
//  LittleMarket
//
//  Created by J on 2016/11/3.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class Sign00ViewController: UIViewController {
    @IBOutlet weak var tvDetail: UITextView!

    @IBAction func Go(_ sender: UIButton) {
    }
    @IBAction func Cancel(_ sender: UIButton) {
        self.view.endEditing(true)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        // 条款显示

        tvDetail.text = Magic.AppDetail
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
