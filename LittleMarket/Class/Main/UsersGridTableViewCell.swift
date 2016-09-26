//
//  UsersGridTableViewCell.swift
//  LittleMarket
//
//  Created by J on 2016/9/26.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class UsersGridTableViewCell: UITableViewCell {

    // MARK: - 变量
    @IBOutlet weak var imageGrid: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    
    //    MARK: - 方法
    func bindModel(model:UsersGridModel){
        lbName.text = model.temp_pname
        lbInfo.text = model.infonote
        Alamofire.request("https://httpbin.org/image/png").responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.imageGrid.image = image
            }
        }
    }

}
