//
//  PDBarChartCell.swift
//  pomodoro
//
//  Created by JianShen on 8/1/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import UIKit

class PDBarChartCell: UICollectionViewCell {
    
    var barHeightConstraint : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init? with coder is not implemented")
    }
    
    func setup(){
        self.addSubview(label)
        label.textAlignment = .center
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            
            ])
        
        self.addSubview(bar)
        //??
        barHeightConstraint = bar.heightAnchor.constraint(equalToConstant: 0)
        barHeightConstraint?.isActive = true
        NSLayoutConstraint.activate([
//            bar.topAnchor.constraint(equalTo: self.topAnchor),
            bar.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -10),
            bar.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            bar.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
            ])
    }
    
    var bar: UIView = {
        var bar = UIView(frame: .zero)
        bar.backgroundColor = .orange
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    
    var label : UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .left
        
        let customFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setDay(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        label.text = formatter.string(from: date)
    }
    
    
    func setBarHeight(maxTime: Int, seconds: Int) {
        let percentFill = CGFloat(seconds)/CGFloat(maxTime)
        self.barHeightConstraint?.constant = (self.frame.height - 45) * percentFill
    }
}
