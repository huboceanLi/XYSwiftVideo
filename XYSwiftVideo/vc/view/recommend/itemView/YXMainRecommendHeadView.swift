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

    func showTitle(index: Int, dic: [String: [RecommendListResponse]]) {
        
        let keys = Array(dic.keys)
        if keys.contains("1"), index == 0 { //电影
            self.name.text = "电影"
            return
        }
        if keys.contains("2"), index == 1 { //电视剧
            self.name.text = "电视剧"
            return
        }
        if keys.contains("3"), index == 2 { //综艺
            self.name.text = "综艺"
            return
        }
        if keys.contains("4"), index == 3 { //动漫
            self.name.text = "动漫"
            return
        }
        if keys.contains("24"), index == 4 { //记录片
            self.name.text = "记录片"
            return
        }
        self.name.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
