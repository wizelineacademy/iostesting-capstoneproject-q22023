//
//  UIFont+Extensions.swift
//  MiniBootcamp
//
//  Created by Marco Alonso Rodriguez on 17/05/23.
//

import Foundation

import UIKit

extension UIFont {

    static func bold(withSize size: CGFloat) -> UIFont? {
        UIFont(name: "Helvetica-Bold", size: size)
    }

    static func normal(withSize size: CGFloat) -> UIFont? {
        UIFont(name: "Helvetica", size: size)
    }
}
