//
//  YXSearchViewController.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/13.
//

import UIKit
import SnapKit
import QMUIKit

class YXSearchViewController: YXBaseViewController {

    var dataSource: [RecommendListResponse] = []
    
    private lazy var searchView: YXSearchView = {
        let view = YXSearchView(frame: .zero)
        view.name.delegate = self
        view.handleSearchCallback = { [weak self] in
            guard let self = self else { return }
            self.searchAction()
        }
        return view
    }()
    
    public lazy var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("搜索", for: .normal)
        button.setTitleColor(UIColor.color4F80FF(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        return button
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
        tableView.register(YXSearchCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.updateEmpty(withImageName: "uk_nodata", title: "暂无数据")
        return tableView
    }()
    
    private lazy var rightItems: [Any] = {
        var rightSpaceItem = YHCusNavigationSpaceItem()
        rightSpaceItem.space = 10.0
        
        var rightAddItem = YHCusNavigationBarItem()
        rightAddItem.width = 40.0
        rightAddItem.view = self.searchButton
        
        return [rightAddItem, rightSpaceItem]
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchView.name.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldInputChange(notification:)), name: UITextField.textDidChangeNotification, object: nil)

    }
    
    func setUpUI() {
        self.cusNaviBar.hideNaviBar = false
        self.cusNaviBar.rightItems = rightItems
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        self.cusNaviBar.backgroundColor = .clear
        self.view.backgroundColor = UIColor.colorFFFFFF()
        
        self.cusNaviBar.addSubview(searchView)

        searchView.snp.makeConstraints { make in
            make.left.equalTo(self.defaultNaviBackButton.snp_right).offset(0)
            make.bottom.equalTo(self.cusNaviBar.snp_bottom).offset(-4)
            make.right.equalTo(self.searchButton.snp_left).offset(-12)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
        }
        
        self.changeButtonStatus(isShow: false)
    }
    
    @objc private func searchAction() {
        
        guard let keywords = self.searchView.name.text else { return }

        SearchMovies.execute(keywords: keywords, page: 0).then { list ->Promise<Void> in
            self.searchView.name.resignFirstResponder()
            self.dataSource.append(contentsOf: list)
            self.tableView.reloadData()
            return Promise<Void>.resolve()
        }
    }
    
    @objc private func textFieldInputChange(notification: NSNotification) {
        
        if let str = self.searchView.name.text, str.count >= 1 {
            self.changeButtonStatus(isShow: true)
            return
        }
        self.changeButtonStatus(isShow: false)
    }
    
    func changeButtonStatus(isShow: Bool) {
        
        if isShow {
            self.searchButton.isEnabled = true
            searchButton.setTitleColor(UIColor.color4F80FF(), for: .normal)
            return
        }
        self.searchButton.isEnabled = false
        searchButton.setTitleColor(UIColor.color8F9BAF(), for: .normal)
    }
}

extension YXSearchViewController: QMUITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}

extension YXSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 160 * 60 / 120 + 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! YXSearchCell

        cell.getModel(model: self.dataSource[indexPath.row])
        
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
        vc.videoId = model.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

