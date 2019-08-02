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
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Study Time For Each Subject:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
