//
//  YXPagePushUtil.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/13.
//

import UIKit

class YXPagePushUtil: NSObject {

    
    @objc static func pushToViewController(vc: UIViewController, isAnimated: Bool) {
        let navVC = YXDefine.getNavigationController()
        if let index = navVC.viewControllers.lastIndex(of: vc),
            index == (navVC.viewControllers.count - 1)
        {
            navVC.popViewController(animated: true)
            return
        }
        
        vc.hidesBottomBarWhenPushed = true
        navVC.pushViewController(vc, animated: isAnimated)
    }
}
