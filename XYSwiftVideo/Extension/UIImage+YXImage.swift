//
//  YXImage.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import Foundation

@objc extension UIImage {
    
    @objc static func xy_bundleImage(name: String) -> UIImage? {

        if let url = Bundle.main.url(forResource: "HYVideoSDK", withExtension: "bundle"),let bundle = Bundle(url: url) {

            let image = UIImage(named: name, in: bundle, compatibleWith: nil)
            return image
        }
        return nil
    }
}
