//
//  YXMainRecommendHeadView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/11.
//

import UIKit
import SnapKit

class YXMainRecommendHeadView: UICollectionReusableView {

    lazy var name: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.text = "Mobile"
        lbl.textColor = UIColor.color0D1324()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        
        self.backgroundColor = UIColor.clear
        self.addSubview(name)
        name.snp_makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(16)
            make.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
