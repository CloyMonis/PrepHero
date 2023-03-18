//
//  PrepExtensions.swift
//  PrepHero
//
//  Created by Cloy Vserv on 18/02/23.
//

import Foundation
import UIKit

struct AppColors {
    static let viewBorder = UIColor(hex: "#ada4a5")?.cgColor
    static let viewActivity = UIColor(hex: "#FFDAA1")
    static let appThemeColor = UIColor(hex: "#FAA21C")
}

extension UIScrollView {
    func customize() {
        self.bounces = false
    }
}

extension UIView {
    func customizeScrollContentView() {
        self.backgroundColor = .clear
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return nil
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
