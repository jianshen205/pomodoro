//
//  PDHeaderCell.swift
//  pomodoro
//
//  Created by JianShen on 7/31/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import UIKit

class PDHeaderCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init? with coder is not implemented")
    }
    
    func setup(){
        self.backgroundColor = .orange
    }
    
}
