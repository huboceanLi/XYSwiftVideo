//
//  YXSearchCell.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/18.
//

import UIKit
import SnapKit
import YYWebImage

class YXSearchCell: UITableViewCell {

    lazy var headImageView: UIImageView = {
        let headImageView: UIImageView = UIImageView.init(frame: .zero)
        headImageView.layer.cornerRadius = 6.0
        headImageView.backgroundColor = UIColor.clear
        headImageView.layer.masksToBounds = true
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    lazy var name: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = UIColor.color0D1324()
        return lbl
    }()
    
    lazy var des: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.font = UIFont.systemFont(ofSize: 12.0)
        lbl.textColor = UIColor.color8F9BAF()
        lbl.numberOfLines = 3
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear

        self.contentView.addSubview(headImageView)
        self.contentView.addSubview(name)
        self.contentView.addSubview(des)

        headImageView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp_left).offset(12)
            make.width.equalTo(60)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10);
            make.top.equalTo(self.contentView.snp_top).offset(10);
        }
        
        name.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView.snp_right).offset(14)
            make.right.equalTo(self.contentView.snp_right).offset(-12)
            make.top.equalTo(self.contentView.snp_top).offset(12)
            make.height.equalTo(20)
        }
        
        des.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView.snp_right).offset(14)
            make.right.equalTo(self.contentView.snp_right).offset(-12)
            make.top.equalTo(self.name.snp_bottom).offset(5)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-12);
        }
    }

    func getModel(model: RecommendListResponse) {
        self.headImageView.yy_setImage(with: URL(string: model.vod_pic), placeholder: UIImage.xy_bundleImage(name: "uk_image_fail"))
        self.name.text = model.vod_name
        
        var str = ""
        if model.type_id_1 == 1 {
            str = "电影";
        }else if model.type_id_1 == 2 {
            str = "电视剧";
        }else if model.type_id_1 == 3 {
            str = "综艺";
        }else if model.type_id_1 == 4 {
            str = "动漫";
        }else if model.type_id_1 == 24 {
            str = "记录片";
        }else {
            str = "其他";
        }
        var c = model.vod_year + "/" + str + "/" + model.vod_area
        
        var content = model.vod_content
        content = content.replacingOccurrences(of: "<p>", with: "")
        content = content.replacingOccurrences(of: "</p>", with: "")
        if c.count > 0 {
            c = c + "/" + model.vod_content
        }
        self.des.text = c
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
