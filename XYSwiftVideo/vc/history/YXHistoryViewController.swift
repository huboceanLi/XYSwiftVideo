//
//  YXHistoryViewController.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/19.
//

import UIKit
import SnapKit
import QMUIKit
import YYWebImage

class YXHistoryViewController: YXBaseViewController {

    var dataSource: [YXHistoryRecordModel] = []

    public lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.xy_bundleImage(name: "uk_center_clear"), for: .normal)
        button.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightItems: [Any] = {
        var rightSpaceItem = YHCusNavigationSpaceItem()
        rightSpaceItem.space = 10.0
        
        var rightAddItem = YHCusNavigationBarItem()
        rightAddItem.width = 40.0
        rightAddItem.view = self.clearButton
        
        return [rightAddItem, rightSpaceItem]
    }()
    
    lazy var tableView: UITableView = {

        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundView = nil;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
        tableView.updateEmpty(withImageName: "uk_nodata", title: "暂无数据")
        tableView.register(YXSearchCell.classForCoder(), forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    func setUpUI() {
        self.cusNaviBar.hideNaviBar = false
        self.cusNaviBar.rightItems = rightItems
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        self.cusNaviBar.backgroundColor = .clear
        self.defaultNaviTitleLabel.text = "播放历史"
        self.view.backgroundColor = UIColor.colorFFFFFF()
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
        }
        
        self.getData()
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.dataSource = YXDefine.getHistory()
            self.tableView.reloadData()
        }
    }
    
    @objc private func clearAction() {
        YXDefine.removeFile()
        self.dataSource = []
        self.tableView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEVIDEOHISTORY"), object: nil, userInfo: nil)
    }
}

extension YXHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 160 * 60 / 120 + 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! YXSearchCell

        let model = self.dataSource[indexPath.row]

        cell.headImageView.yy_setImage(with: URL(string: model.imageUrl), placeholder: UIImage.xy_bundleImage(name: "uk_image_fail"))
        cell.name.text = model.name + "-" + model.playName
        
        if model.playDuration < model.duration {
            cell.des.text = "剩余:" + YXDefine.changeTime(withDuration: model.duration - model.playDuration)
        }else if model.playDuration == model.duration {
            cell.des.text = "观看结束"
        }else {
            cell.des.text = " "
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = self.dataSource[indexPath.row]
        let vc = YXDetailViewController()
        vc.videoId = model.tvId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
