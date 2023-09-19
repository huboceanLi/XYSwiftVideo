//
//  YXDetailContentView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/19.
//

import UIKit
import SnapKit

class YXDetailContentView: UIView {

    lazy var contentLab: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor.color8F9BAF()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        self.backgroundColor = UIColor.green
        
        self.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(15)
            make.width.equalTo(UIDevice.YH_Width - 30.0)
            make.top.equalTo(self.snp_top).offset(0)
            make.bottom.equalTo(self.snp_bottom).offset(-15)
        }
    }

    func getModel(model: DetailListResponse?) {
        
        guard let response = model else {return}
        
        var content = ""
        
        if response.vod_director.count > 0 {
            content = "导演: " + response.vod_director + "\n"
        }
        
        if response.vod_writer.count > 0 {
            content = content + "作者: " + response.vod_writer + "\n"
        }
        
        if response.vod_actor.count > 0 {
            content = content + "主演: " + response.vod_actor + "\n"
        }
        
        if response.vod_class.count > 0 {
            content = content + "类型: " + response.vod_class + "\n"
        }
        
        if response.vod_area.count > 0 {
            content = content + "地区: " + response.vod_area + "\n"
        }
        
        var c = response.vod_content
        c = c.replacingOccurrences(of: "<p>", with: "")
        c = c.replacingOccurrences(of: "</p>", with: "")
        c = c.trimmingCharacters(in: .whitespaces)
        
        if c.count > 0 {
            content = " \n \n" + content + c + "\n"
        }
        
        self.contentLab.text = content
        //vod_director vod_writer vod_actor vod_class vod_area vod_content
        //导演 作者 主演 类型 地区 详情
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
