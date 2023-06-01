//
//  UIFont+Extensions.swift
//  Capstone
//
//  Created by Carlos Ceja.
//

import UIKit

extension UIFont {

    static func bold(withSize size: CGFloat) -> UIFont? {
        UIFont(name: "Helvetica-Bold", size: size)
    }
    
    static func normal(withSize size: CGFloat) -> UIFont? {
        UIFont(name: "Helvetica", size: size)
    }

}
