//
//  Views.swift
//  CRIC_App
//
//  Created by BJIT on 25/11/1401 AP.
//

import Foundation
import UIKit
extension UIView {
    func round(_ radious: CGFloat = 10) {
        DispatchQueue.main.async { [self] in
            layer.cornerRadius = radious
            clipsToBounds = true
        }
    }
    func addBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
