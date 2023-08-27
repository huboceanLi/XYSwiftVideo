//
//  YXCusNavigationBar.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/8/24.
//

import UIKit

@objc public class YHCusNavigationBarItem: NSObject {
    @objc public var view: UIView!
    @objc public var width: CGFloat = 50.0
}

@objc public class YHCusNavigationSpaceItem: NSObject {
    @objc public var space: CGFloat = 0.0
}

@objc public class YHCusNavigationToolItem: NSObject {
    @objc public var view: UIView!
    @objc public var height: CGFloat = 0.0
}

private struct YHCusNavigationBarAssociatedKeys {
    static var gradientKey = "com.bbcgat.customNavigationBar.gradientLayer.key"
}

@objcMembers public class YXCusNavigationBar: UIView {

    deinit {
        print("\(NSStringFromClass(YXCusNavigationBar.classForCoder())) deinit")
    }

    @objc public lazy var lineView: UIView = {
        let lineView = UIView()
        return lineView
    }()
    
    
    /// titleView，可以为空
    /// 如果设置了宽度，将优先使用设置的宽度
    /// 如果没有设置宽度，将根据左右item自动计算宽度
    /// 高度会自动适应
    @objc public var titleView: UIView?
    
    @objc public lazy var barView: UIView = {
        let barView = UIView()
        barView.backgroundColor = UIColor.clear
        return barView
    }()
    
    @objc public lazy var toolView: UIView = {
        let toolView = UIView()
        toolView.backgroundColor = UIColor.clear
        return toolView
    }()
    
    private let barHeight: CGFloat = 44.0
    
    @objc public var gradientLayer: CAGradientLayer?
    @objc public var hideNaviBar: Bool = true //
    @objc public var hideBar: Bool = false //
    @objc public var hideStatusBar: Bool = false //
    @objc public var hideToolBar: Bool = false //
    @objc public var leftItems: [Any] = []
    @objc public var rightItems: [Any] = []
    @objc public var toolItem: YHCusNavigationToolItem?
    
    @objc public var lineColor: UIColor = UIColor.gray {
        didSet {
            self.lineView.backgroundColor = lineColor
        }
    }

    private var _origin: CGPoint = .zero
    private var _width: CGFloat = UIScreen.main.bounds.size.width
    
    @objc public init() {
        super.init(frame: .zero)

        addSubview(barView)
        addSubview(toolView)
        addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc public func reloadUI(origin: CGPoint = .zero, width: CGFloat = UIScreen.main.bounds.size.width) {
        _origin = origin
        _width = width
        
        if self.hideNaviBar {
            self.barView.isHidden = true
            self.toolView.isHidden = true
            self.lineView.isHidden = true
            self.frame = .zero
            self.barView.frame = .zero
            self.toolView.frame = .zero
            return
        }
        self.lineView.isHidden = true
        
        let ox: CGFloat = origin.x
        let oy: CGFloat = origin.y
        var height: CGFloat = 0.0
        

        if !self.hideStatusBar {
            height += UIDevice.YH_Fringe_Height
        }
        
        if !self.hideBar {
            self.barView.isHidden = false
            self.barView.frame = CGRect(x: ox, y: height, width: width, height: self.barHeight)
            height = height + self.barHeight
        } else {
            self.barView.isHidden = true
            self.barView.frame = .zero
        }
        
        
        self.toolView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        if let toolItem = self.toolItem, !self.hideToolBar, toolItem.height > 0.0 {
            self.toolView.isHidden = false
            self.toolView.frame = CGRect(x: ox, y: height, width: width, height: toolItem.height)
            self.toolView.addSubview(toolItem.view)
            toolItem.view.frame = self.toolView.bounds
            height = height + toolItem.height
        } else {
            self.toolView.isHidden = true
            self.toolView.frame = .zero
        }
        
        // frame
        self.frame = CGRect(x: ox, y: oy, width: width, height: height)
        
        self.barView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        var leftDistance: CGFloat = 0.0
        for (_, item) in self.leftItems.enumerated() {
            if let spaceItem = item as? YHCusNavigationSpaceItem {
                leftDistance = leftDistance + spaceItem.space
            } else if let item = item as? YHCusNavigationBarItem {
                if let label = item.view as? UILabel {
                    label.adjustsFontSizeToFitWidth = true
                } else if let button = item.view as? UIButton {
                    button.titleLabel?.adjustsFontSizeToFitWidth = true
                }
                self.barView.addSubview(item.view)
                item.view.frame = CGRect(x: leftDistance, y: 0, width: item.width, height: self.barHeight)
                leftDistance = leftDistance + item.width
            }
        }
        
        var rightDistance: CGFloat = 0.0
        for (_, item) in rightItems.enumerated().reversed() {
            if let spaceItem = item as? YHCusNavigationSpaceItem {
                rightDistance = rightDistance + spaceItem.space
            } else if let item = item as? YHCusNavigationBarItem {
                if let label = item.view as? UILabel {
                    label.adjustsFontSizeToFitWidth = true
                } else if let button = item.view as? UIButton {
                    button.titleLabel?.adjustsFontSizeToFitWidth = true
                }
                self.barView.addSubview(item.view)
                item.view.frame = CGRect(x: width - rightDistance - item.width, y: 0, width: item.width, height: self.barHeight)
                rightDistance = rightDistance + item.width
            }
        }
        
        if let titleView = titleView {
            var titleWidth = (width / 2.0 - max(leftDistance, rightDistance)) * 2;
            if titleView.bounds.size.width > 0 {
                titleWidth = titleView.bounds.size.width
            }
            if titleWidth > 0 {
                self.barView.addSubview(titleView)
                titleView.frame = CGRect(x: (width - titleWidth) / 2.0, y: 0, width: titleWidth, height: self.barHeight)
            }
        }
        
        if !self.hideBar {
            self.lineView.frame = CGRect(x: ox, y: self.barView.frame.origin.y + self.barView.frame.size.height - 0.5, width: width, height: 0.5)
        }
        
        let tmpGradientLayer = objc_getAssociatedObject(self, &YHCusNavigationBarAssociatedKeys.gradientKey)
        if let tmpGradientLayer = tmpGradientLayer as? CAGradientLayer {
            tmpGradientLayer.removeFromSuperlayer()
        }
        if let gradientLayer = self.gradientLayer {
            objc_setAssociatedObject(self, &YHCusNavigationBarAssociatedKeys.gradientKey, gradientLayer, .OBJC_ASSOCIATION_ASSIGN)
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        self.lineView.backgroundColor = lineColor
    }
}
