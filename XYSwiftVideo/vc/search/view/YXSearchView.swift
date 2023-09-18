//
//  YXSearchView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/13.
//

import UIKit
import SnapKit
import QMUIKit

class YXSearchView: UIView {

    var handleSearchCallback: (() -> Void)?

    private lazy var searchContentView: UIView = {
        let searchContentView = UIView()
        searchContentView.layer.backgroundColor = UIColor.colorFFFFFF().withAlphaComponent(0.5).cgColor
        searchContentView.layer.cornerRadius = 16.0
        searchContentView.layer.masksToBounds = true
        return searchContentView
    }()
    
    private lazy var searchImageView: UIImageView = {
        let searchImageView = UIImageView()
        searchImageView.image = UIImage.xy_bundleImage(name: "uk_search_wh")
        return searchImageView
    }()
    
    lazy var name: QMUITextField = {
        let name = QMUITextField()
        name.placeholder = "您想看的都在这里..."
        name.placeholderColor = UIColor.color8F9BAF()
        name.textColor = UIColor.color0D1324().withAlphaComponent(0.4)
        name.font = UIFont.systemFont(ofSize: 14)
        name.returnKeyType = .search
        name.text = "暗战"
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        self.backgroundColor = UIColor.clear
        
        addSubview(searchContentView)
        searchContentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
        }
        
        self.searchContentView.addSubview(searchImageView)
        searchImageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalTo(self.searchContentView.snp_left).offset(10)
        }
        
        self.searchContentView.addSubview(name)
        name.snp.makeConstraints { make in
            make.left.equalTo(self.searchImageView.snp_right).offset(8)
            make.right.bottom.top.equalToSuperview()
        }
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(viewTap(gesture:)))
        self.addGestureRecognizer(tapGesture2)
    }

    @objc private func viewTap(gesture: UIGestureRecognizer) {
        self.handleSearchCallback?()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.layer.cornerRadius = self.YH_Height / 2.0
//        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
