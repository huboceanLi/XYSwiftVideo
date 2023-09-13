//
//  YXSearchView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/13.
//

import UIKit
import SnapKit

class YXSearchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        self.backgroundColor = UIColor.white
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.YH_Height / 2.0
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
