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
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 10.0)
        lbl.text = "Mobile"
        lbl.textColor = UIColor.color0D1324()
        return lbl
    }()
    
    lazy var scoreLab: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16.0)
        lbl.text = "Mobile"
        lbl.textColor = UIColor.color0D1324()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
