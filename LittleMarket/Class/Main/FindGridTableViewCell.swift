//
//  FindGridTableViewCell.swift
//  LittleMarket
//
//  Created by J on 2016/9/23.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class FindGridTableViewCell: UITableViewCell {
    // MARK: - 变量
    @IBOutlet weak var ivImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var lbName: UILabel!
    //    MARK: - 方法
    func bindModel(model: FindGridModel,index:Int) {
        
        switch Judge {
        case .test:
            //let indexs = index
            
            bgView.backgroundColor = UIColor.yellow
            
            lbName.text = "类别名称"
            lbInfo.text = "分类简介：介绍该类型的基本信息，和所售商品信息...为用户提供导航"
            //        imageProduct.image = UIImage.init(data: Data.)
            

            ivImg.image = UIImage.init(imageLiteralResourceName: "default_img")
        case .debug:
            //let indexs = index
            
            bgView.backgroundColor = UIColor.yellow
            
            lbName.text = model.name
            lbInfo.text = model.note
            let url = URL(string: model.pic)!
            self.ivImg.kf.setImage(with: url,
                                          placeholder: UIImage.init(imageLiteralResourceName: "default_img"),
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
            
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
