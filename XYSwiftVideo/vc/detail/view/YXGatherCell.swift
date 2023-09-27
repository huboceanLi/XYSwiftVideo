//
//  YXGatherCell.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/27.
//

import UIKit
import SnapKit

class YXGatherCell: UICollectionViewCell {
    
    lazy var name: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 13.0)
        lbl.textColor = UIColor.color0D1324()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }
    
    func initializeUI() {
        addSubview(name)
        name.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
