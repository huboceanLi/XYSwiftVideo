//
//  YXMainViewController.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import UIKit
import SnapKit

@objcMembers public class YXMainViewController: YXBaseViewController  {

    private lazy var contentView: YXMainContentView = {
        let view = YXMainContentView(frame: .zero)
        return view
    }()
    
    private lazy var recodeView: YXHistoryRecodeView = {
        let view = YXHistoryRecodeView(frame: .zero)
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
//            vc.clickHistoryRecordVideoBack = { [weak self] model in
//                guard let self = self else {return}
//                self.recodeView.getModel(model: model)
//            }
        }
        return view
    }()
    
    @objc private func settingAction() {
        let vc = YXHistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        

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
        
        YXDefine.saveJLADKey(false)
        
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
        
        self.view.addSubview(recodeView)
        recodeView.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp_left).offset(0)
            make.height.equalTo(60)
            make.bottom.equalTo(self.view.snp_bottom).offset((YXDefine.isPhoneX() ? -120 : -80))
        }

        self.recodeView.clickTapVideoBack = { [weak self] tvID in
            guard let self = self else {return}
            
            if YXDefine.getADJLKey() {
                let vc = YXDetailViewController()
                vc.videoId = tvID
                YXPagePushUtil.pushToViewController(vc: vc, isAnimated: true)
            }else {
                let alertController = UIAlertController(title: "",
                                message: "看完视频可以获取所有视频观看权限!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in

                    YXTypeManager.shareInstance().showAd(with: .detail_touch) { result in
                        DispatchQueue.main.async {
                            if result {
                                YXDefine.saveJLADKey(true)
                                let vc = YXDetailViewController()
                                vc.videoId = tvID
                                YXPagePushUtil.pushToViewController(vc: vc, isAnimated: true)
                            }
                        }
                    }
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            }

        }
        
        self.getHistoryFirst()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificaDidOpen(notifcation:)), name: Notification.Name(rawValue: "CHANGEVIDEOHISTORY"), object: nil)

    }

    @objc private func notificaDidOpen(notifcation: Notification) {
        self.getHistoryFirst()
    }
    
    func getHistoryFirst() {
        let hisArr = YXDefine.getHistory()
        if hisArr.count > 0, let f = hisArr.first {
            self.recodeView.isHidden = false
            self.recodeView.getModel(model: f)
        }else {
            self.recodeView.isHidden = true
        }
    }
    
}
