//
//  YXHistoryRecodeView.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/10/4.
//

import UIKit
import QMUIKit
import SnapKit
import YYModel

class YXHistoryRecodeView: UIView {

    var clickTapVideoBack: ((Int) -> Void)?

    var tvId: Int = 0
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 20.0
        view.layer.masksToBounds = true
        view.layer.qmui_maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = UIColor.colorFFFFFF()
        return view
    }()
    
    private lazy var name: UILabel = {
        let name = UILabel(frame: .zero)
        name.text = "daf啊放过五谷丰登"
        name.font = UIFont.systemFont(ofSize: 13)
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        self.backgroundColor = UIColor.clear
        
        self.layer.shadowColor = UIColor.color0D1324().withAlphaComponent(1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.clipsToBounds = false
        
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        self.contentView.addSubview(name)
        name.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let clickGesture = UITapGestureRecognizer(target: self, action: #selector(clickGestureAct))
        contentView.addGestureRecognizer(clickGesture)
    }

    @objc private func clickGestureAct(gesture: UITapGestureRecognizer) {
        if let closure = self.clickTapVideoBack {
            closure(self.tvId)
        }
    }
    
    
    func getModel(model: YXHistoryRecordModel) {
        self.tvId = model.tvId
        
        let playDuration = YXDefine.changeTime(withDuration: model.playDuration)
        let t = "    " + playDuration + " | "
        var name: String = model.name
        
        if name.count > 7 {
            name = String(name.prefix(6)) + "..."
        }
        
        let j = " 继续观看    "
        
        self.name.attributedText = YXDefine.attributedString(t, name: name, j: j)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
