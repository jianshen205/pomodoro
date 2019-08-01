//
//  PDTimeDisplayCell.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit

class PDTimeDisplayCell: UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        self.backgroundColor = .white
        self.addSubview(primaryText)
        self.addSubview(secondaryText)
        NSLayoutConstraint.activate([
            primaryText.centerYAnchor.constraint(equalTo: centerYAnchor),
            primaryText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            secondaryText.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondaryText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            primaryText.trailingAnchor.constraint(lessThanOrEqualTo: secondaryText.leadingAnchor, constant: -15)])
        
    }
    
    let primaryText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondaryText: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .right
        
        let customFont = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .light)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
