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
        lbl.numberOfLines = 0
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
            make.width.equalTo(UIDevice.YH_Width - 30.0)
            make.top.equalTo(self.snp_top).offset(15)
        }
        
        briefLab.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(15)
            make.width.equalTo(UIDevice.YH_Width - 30.0)
            make.top.equalTo(self.titleLab.snp_bottom).offset(6)
            make.bottom.equalTo(self.snp_bottom).offset(-15)
        }
    }

    func getModel(model: DetailListResponse?) {
        
        guard let response = model else {return}
        self.titleLab.text = response.vod_name
        
        let c = response.vod_douban_score + " / " + response.vod_year + " / " + response.vod_lang + " / " + response.type_name
        self.briefLab.text = c
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
