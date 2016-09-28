//
//  MyGridTableViewCell.swift
//  LittleMarket
//
//  Created by J on 2016/9/22.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class MyGridTableViewCell: UITableViewCell {

//    MARK: - 变量
    @IBOutlet weak var lbPart: UILabel!
    @IBOutlet weak var lbOwer: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var lbNote: UILabel!
    
//    MARK: - 方法
    func bindModel(model: MyGridModel,index:Int) {
        
        
        //            测试
        switch Judge {
        case .test:
            lbPart.text = "商品分类"
            lbOwer.text = "名称"
            lbNote.text = "商品简介：用来简单介绍所出售的商品信息，以此确定是否进一步取得联系"
            imageProduct.image = UIImage.init(imageLiteralResourceName: "default_img")
        case .debug:
            //let indexs = index
            lbPart.text = model.temp_bdid
            lbOwer.text = model.temp_pname
            lbNote.text = model.infonote
            //        imageProduct.image = UIImage.init(data: Data.)
            Alamofire.request("https://httpbin.org/image/png").responseImage { response in
                debugPrint(response)
                
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    self.imageProduct.image = image
                }
            }
            
        case .run:
            break
            
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
