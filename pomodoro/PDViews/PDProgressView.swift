//
//  PDProgressView.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit

class PDProgressView: UIView {
    var progress: CGFloat = 0.0
    let lineWidth: CGFloat = 10
    var trackLayer: CAShapeLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress( value: CGFloat){
        progress = value
        self.trackLayer?.strokeEnd = 1 - progress
        NSLog("%.f%%", progress * 100)
    }

    func setup() {
        self.backgroundColor = .green
        let shapeLayer: CAShapeLayer = CAShapeLayer.init()
        shapeLayer.bounds = CGRect.init(x:0, y:0, width: self.frame.width, height: self.frame.height)
        shapeLayer.lineWidth = self.lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.lightGray.cgColor

        let center: CGPoint = CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height/2)
        let bezierPath: UIBezierPath = UIBezierPath.init(arcCenter: center, radius: (UIScreen.main.bounds.width - 150 - lineWidth) / 2, startAngle: CGFloat(-0.5 * Double.pi), endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        shapeLayer.path = bezierPath.cgPath
        self.layer.addSublayer(shapeLayer)


        self.trackLayer = CAShapeLayer.init()
        self.trackLayer?.bounds = CGRect.init(x:0, y:0, width: self.frame.width, height: self.frame.height)
        self.trackLayer?.fillColor = UIColor.clear.cgColor
        self.trackLayer?.lineWidth = self.lineWidth
        self.trackLayer?.strokeColor = UIColor.orange.cgColor
        self.trackLayer?.lineCap = CAShapeLayerLineCap.round
        self.trackLayer?.path = bezierPath.cgPath
        self.layer.addSublayer(self.trackLayer!)
        


    }
}
