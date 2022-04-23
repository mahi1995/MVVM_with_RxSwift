//
//  UIView+Extension.swift
//  SearchProductProject
//
//  Created by Mahika on 23/04/2022.
//

import UIKit

extension UIView {
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.grey60.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 4)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
}
