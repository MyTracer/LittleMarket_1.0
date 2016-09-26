//
//  UserMenuTableViewCell.swift
//  LittleMarket
//
//  Created by J on 2016/9/26.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

enum UserMenuItem: Int {
    // rawValue 对应相应的 cellHeight
    case Grids = 100
    case User = 44
}

protocol UserMenuDelegate: class {
    func selectMenuItem(item: UserMenuItem)
}

class UserMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var btnGrid: UIButton!
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var lineX: NSLayoutConstraint!
    
    lazy var lastSelectedItem: UIButton = {
        return self.btnGrid
    }()
    
    lazy var selectedColor: UIColor! = {
        return self.btnGrid.titleColor(for: .normal)
    }()
    
    let deselectedColor = UIColor.lightGray
    weak var delegate: UserMenuDelegate?
    func addMenuItemTarget() {
        [btnGrid, btnUser].forEach {
            $0!.addTarget(self, action: #selector(UserMenuTableViewCell.selectMenuItem(item:)), for: .touchUpInside)
        }
    }
    
    func selectMenuItem(item: UIButton) {
        //将选中的 item 设为选中色，并将上一次选中的 item 恢复为未选中色
        item.setTitleColor(selectedColor, for: .normal)
        lastSelectedItem.setTitleColor(deselectedColor, for: .normal)
        lastSelectedItem = item
        
        //改变指示条的约束，使其水平中心点与选中 item 的水平中心点相同
        let newCenterX = NSLayoutConstraint(item: line, attribute: .centerX, relatedBy: .equal, toItem: item, attribute: .centerX, multiplier: 1, constant: 0)
        
        lineX.isActive = false
        lineX = newCenterX
        lineX.isActive = true
        
        //通知代理
        delegate?.selectMenuItem(item: UserMenuItem(rawValue: item.tag)!)
    }

}
