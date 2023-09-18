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
    
    
    
    //文字颜色
    //深灰色-非标题
    static func color8F9BAF() -> UIColor {
        return UIColor.yx_getColor(hexColor: "8F9BAF")
    }
    //黑色
    static func color0D1324() -> UIColor {
        return UIColor.yx_getColor(hexColor: "0D1324")
    }
    
    //主题颜色
    static func color4F80FF() -> UIColor {
        return UIColor.yx_getColor(hexColor: "4F80FF")
    }
    
    //背景色
    static func colorFFFFFF() -> UIColor {
        return UIColor.yx_getColor(hexColor: "FFFFFF")
    }

    //评分--红色
    static func colorFF4500() -> UIColor {
        return UIColor.yx_getColor(hexColor: "FF4500")
    }

}

