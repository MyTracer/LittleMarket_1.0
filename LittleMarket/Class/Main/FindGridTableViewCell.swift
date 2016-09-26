//
//  FindGridTableViewCell.swift
//  LittleMarket
//
//  Created by J on 2016/9/23.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class FindGridTableViewCell: UITableViewCell {
    // MARK: - 变量
    @IBOutlet weak var ivImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var lbName: UILabel!
    //    MARK: - 方法
    func bindModel(model: FindGridModel,index:Int) {
        
        //let indexs = index
        
        bgView.backgroundColor = UIColor.yellow
        
        lbName.text = model.temp_pname
        lbInfo.text = model.infonote
        //        imageProduct.image = UIImage.init(data: Data.)
        Alamofire.request("https://httpbin.org/image/png").responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.ivImg.image = image
            }
        }
        
        
    }
    //    MARK: - 函数
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
