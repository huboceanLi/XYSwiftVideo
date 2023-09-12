//
//  YXMainRecommendCell.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/11.
//

import UIKit
import SnapKit

class YXMainRecommendCell: UICollectionViewCell {
    
    lazy var headImageView: UIImageView = {
        let headImageView: UIImageView = UIImageView.init(frame: .zero)
        headImageView.layer.cornerRadius = 6.0
        headImageView.layer.masksToBounds = true
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    lazy var name: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 13.0)
        lbl.text = "Mobile"
        lbl.textColor = UIColor.color0D1324()
        return lbl
    }()
    
    lazy var des: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 10.0)
        lbl.text = "Mobile"
        lbl.textColor = UIColor.colorFFFFFF()
        lbl.layer.backgroundColor = UIColor.color222222().withAlphaComponent(0.5).cgColor
        return lbl
    }()
    
    lazy var scoreLab: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16.0)
        lbl.text = "Mobile"
        lbl.textColor = UIColor.colorFFFFFF()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        addSubview(self.headImageView)
        addSubview(self.name)
        addSubview(self.des)
        addSubview(self.scoreLab)

        self.name.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
        
        self.headImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.name.snp_top).offset(-6)
        }
        self.des.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.headImageView)
            make.height.equalTo(16)
        }
        
        self.scoreLab.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView.snp_left).offset(8)
            make.top.equalTo(self.headImageView.snp_top).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
