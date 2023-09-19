//
//  YXBriefView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/19.
//

import UIKit
import SnapKit

class YXBriefView: UIView {

    lazy var titleLab: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = UIColor.color0D1324()
        return lbl
    }()
    
    lazy var briefLab: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = UIColor.color8F9BAF()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        self.backgroundColor = UIColor.clear
        
        self.addSubview(titleLab)
        self.addSubview(briefLab)

        titleLab.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(15)
            make.right.equalTo(self.snp_right).offset(-15)
            make.top.equalTo(self.snp_top).offset(15)
        }
        
        briefLab.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(15)
            make.right.equalTo(self.snp_right).offset(-15)
            make.top.equalTo(self.titleLab.snp_bottom).offset(15)
            make.bottom.equalTo(self.snp_bottom).offset(-15)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
