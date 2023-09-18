//
//  YXMainContentViewController.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import UIKit
import SnapKit

@objcMembers public class YXMainContentViewController: YXBaseViewController  {

    private lazy var contentView: YXMainContentView = {
        let view = YXMainContentView(frame: .zero)
        return view
    }()
    
    public lazy var settingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.xy_bundleImage(name: "yx_setting_img"), for: .normal)
        button.addTarget(self, action: #selector(settingAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightItems: [Any] = {
        var rightSpaceItem = YHCusNavigationSpaceItem()
        rightSpaceItem.space = 10.0
        
        var rightAddItem = YHCusNavigationBarItem()
        rightAddItem.width = 40.0
        rightAddItem.view = self.settingButton
        
        return [rightAddItem, rightSpaceItem]
    }()
    
    private lazy var searchView: YXSearchView = {
        let view = YXSearchView(frame: .zero)
        view.name.isEnabled = false
        view.handleSearchCallback = { [weak self] in
            guard let self = self else { return }
            let vc = YXSearchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        return view
    }()
    
    @objc private func settingAction() {
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.cusNaviBar.rightItems = self.rightItems
        self.defaultNaviBackButton.isHidden = true
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        self.cusNaviBar.backgroundColor = .clear
        self.view.backgroundColor = UIColor.colorFFFFFF()
        
        self.cusNaviBar.addSubview(self.searchView)
        
        self.searchView.snp.makeConstraints { make in
            make.left.equalTo(self.cusNaviBar.snp_left).offset(30)
            make.bottom.equalTo(self.cusNaviBar.snp_bottom).offset(-4)
            make.right.equalTo(self.settingButton.snp_left).offset(-12)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
        }
    }

}
