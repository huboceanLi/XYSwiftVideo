//
//  YXPlayVideoView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/19.
//

import UIKit

class YXPlayVideoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        self.backgroundColor = UIColor.black
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
