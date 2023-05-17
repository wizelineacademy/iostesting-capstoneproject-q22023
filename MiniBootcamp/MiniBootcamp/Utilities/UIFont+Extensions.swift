//
//  UIFont+Extensions.swift
//  MiniBootcamp
//
//  Created by Fernando de la Rosa on 17/05/23.
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
