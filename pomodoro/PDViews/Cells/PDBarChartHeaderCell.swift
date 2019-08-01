//
//  PDBarChartHeaderCell.swift
//  pomodoro
//
//  Created by JianShen on 8/1/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit
class PDBarChartHeaderCell: UICollectionViewCell  {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented yet")
    }
    
    func setUpView() {
        self.backgroundColor = .orange
        self.addSubview(titleStack)
        NSLayoutConstraint.activate([
            titleStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleStack.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
    }
    
    func updateText(primaryText: String, secondaryText: String) {
        self.primaryText.text = primaryText
        self.secondaryText.text = secondaryText
        self.accessibilityLabel = primaryText
        self.accessibilityValue = secondaryText
    }
    
    let primaryText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        
        let customFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondaryText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        
        let customFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [primaryText, secondaryText])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
}
