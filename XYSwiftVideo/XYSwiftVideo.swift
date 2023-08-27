//
//  XYSwiftVideo.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/8/24.
//

import UIKit

public enum YXThemeStyle: Int {
    case themeBlue = 0
    case themeBlack = 1
    case themePink = 2
}

@objcMembers public class XYSwiftVideo: NSObject {

    public var themeStyle : YXThemeStyle = .themeBlue

    static public var shared: XYSwiftVideo!
    
    public static func getInstance(themeStyle: YXThemeStyle) -> XYSwiftVideo {
        
        if shared == nil {
            shared = XYSwiftVideo(themeStyle: themeStyle)
        }
        
        return shared
    }
    
    private init(themeStyle: YXThemeStyle) {
        self.themeStyle = themeStyle
        
        super.init()
    }

}
