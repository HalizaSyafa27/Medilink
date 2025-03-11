//
//  CustomView.swift
//  test
//
//  Created by OdiTek Solutions on 30/01/20.
//  Copyright © 2020 OdiTek Solutions. All rights reserved.
//

import UIKit
@IBDesignable
class CustomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var offset:    CGFloat = 60        { didSet { setNeedsDisplay() } }
    @IBInspectable var fillColor: UIColor = .red      { didSet { setNeedsDisplay() } }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()

//        path.move(to: CGPoint(x: bounds.minX + offset, y: bounds.minY))
//        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
//        path.addLine(to: CGPoint(x: bounds.maxX , y: bounds.maxY ))
//        path.addLine(to: CGPoint(x: bounds.minX - offset, y: bounds.maxY ))
        
        path.move(to: CGPoint(x: bounds.minX , y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - offset, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX , y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX + offset, y: bounds.maxY))

        // Close the path. This will create the last line automatically.
        path.close()
        fillColor.setFill()
        path.fill()
    }

}
