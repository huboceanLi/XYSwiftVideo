//
//  UIColor+BC.swift
//  BBChat
//
//  Created by Joey on 2023/8/23.
//

import Foundation

@objc extension UIColor {
    
    static func yx_getColor(hexColor: String) -> UIColor {
        if hexColor.count == 0 {
            return UIColor.clear
        }
        
        var alpha,red,green,blue: CGFloat
        var tHexColor = hexColor
        
        if hexColor.count == 7 || hexColor.count == 6 {
            tHexColor = (tHexColor as NSString).substring(from: hexColor.count - 6)
            tHexColor = "FF" + tHexColor
        }else if hexColor.count == 9 {
            tHexColor = (tHexColor as NSString).substring(from: hexColor.count - 8)
        }else {
            tHexColor = "FF000000"
        }
        
        let scanner = Scanner(string: tHexColor)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            alpha = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            red = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            green = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            blue = CGFloat(hexNumber & 0x000000ff) / 255

            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return UIColor.clear
    }
    
    
    //
    static func colorA2A8C3() -> UIColor {
        return UIColor.yx_getColor(hexColor: "A2A8C3")
    }
    
    static func colorFFFFFF() -> UIColor {
        return UIColor.yx_getColor(hexColor: "FFFFFF")
    }
    
    static func colorFF4500() -> UIColor {
        return UIColor.yx_getColor(hexColor: "FF4500")
    }
    
    static func color000000() -> UIColor {
        return UIColor.yx_getColor(hexColor: "000000")
    }
    
    static func color00C6DB() -> UIColor {
        return UIColor.yx_getColor(hexColor: "00C6DB")
    }
    
    static func colorDADCE7() -> UIColor {
        return UIColor.yx_getColor(hexColor: "DADCE7")
    }
    
    static func color0D1324() -> UIColor {
        return UIColor.yx_getColor(hexColor: "0D1324")
    }
    
    static func colorFF4A4A() -> UIColor {
        return UIColor.yx_getColor(hexColor: "FF4A4A")
    }
    
    static func color222222() -> UIColor {
        return UIColor.yx_getColor(hexColor: "222222")
    }
    
    static func colorEFF0F3() -> UIColor {
        return UIColor.yx_getColor(hexColor: "EFF0F3")
    }
    
    static func colorF3F5F9() -> UIColor {
        return UIColor.yx_getColor(hexColor: "F3F5F9")
    }
    
    static func colorBEBEC0() -> UIColor {
        return UIColor.yx_getColor(hexColor: "BEBEC0")
    }
    
    static func color333333() -> UIColor {
        return UIColor.yx_getColor(hexColor: "333333")
    }
    
    static func color0BCADE() -> UIColor {
        return UIColor.yx_getColor(hexColor: "0BCADE")
    }
    
    static func colorDADCE2() -> UIColor {
        return UIColor.yx_getColor(hexColor: "DADCE2")
    }
}

