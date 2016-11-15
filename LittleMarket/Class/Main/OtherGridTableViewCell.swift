//
//  OtherGridTableViewCell.swift
//  LittleMarket
//
//  Created by J on 2016/9/23.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

import Kingfisher
import Alamofire

class OtherGridTableViewCell: UITableViewCell {

    //    MARK: - 变量
    let sort:SortInfo = SortInfo.shareSortInfo
    @IBOutlet weak var lbPart: UILabel!
    @IBOutlet weak var lbOwer: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var lbNote: UILabel!
    
    //    MARK: - 方法
    func bindModel(model: OtherGridModel,index:Int) {
        
        // 测试
        switch Judge {
        case .test:
            lbPart.text = "商品分类"
            lbOwer.text = "名称"
            lbNote.text = "商品简介：用来简单介绍所出售的商品信息，以此确定是否进一步取得联系"
            imageProduct.image = UIImage.init(imageLiteralResourceName: "default_img")
        case .debug:
            //let indexs = index
            lbPart.text = model.name
            lbOwer.text = " "
            for sortarr in sort.sortArray{
                if sortarr.sortid == model.sortid {
                    lbOwer.text = sortarr.name
                }
            }
            
            lbNote.text = model.note + "    价格:$" + model.price
            
            if let url = URL(string: (API.APIHost + model.pic)){
            self.imageProduct.kf.setImage(with: url,
                                          placeholder: UIImage.init(imageLiteralResourceName: "default_img"),
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
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
