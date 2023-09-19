//
//  YXDetailViewController.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/13.
//

import UIKit
import SnapKit

let playViewHeight = 220.0 * UIDevice.YH_Width / 390.0

class YXDetailViewController: YXBaseViewController {

    var videoId: Int = 0
        
    var detailListResponse: DetailListResponse?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var playVideoView: YXPlayVideoView = {
        let view = YXPlayVideoView(frame: .zero)
        return view
    }()
    
    
    private lazy var briefView: YXBriefView = {
        let view = YXBriefView(frame: .zero)
        return view
    }()
    
    private lazy var gatherView: YXGatherView = {
        let view = YXGatherView(frame: .zero)
        return view
    }()
    
    private lazy var contentView: YXDetailContentView = {
        let view = YXDetailContentView(frame: .zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        
        getData()
    }
    
    func setUpUI() {
        self.cusNaviBar.hideNaviBar = false
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        self.cusNaviBar.backgroundColor = .clear
        self.view.backgroundColor = UIColor.colorFFFFFF()
        
        self.view.addSubview(playVideoView)
        playVideoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
            make.height.equalTo(playViewHeight)
        }
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(UIDevice.YH_Width)
            make.top.equalTo(self.playVideoView.snp_bottom).offset(0)
        }
        
        self.scrollView.addSubview(briefView)
        briefView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        self.scrollView.addSubview(gatherView)
        gatherView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.briefView.snp_bottom).offset(0)
            make.height.equalTo(80)
        }
        
        self.scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.gatherView.snp_bottom).offset(0)
            make.bottom.equalTo(self.scrollView.snp_bottom).offset(-15)
        }
    }
    
    func getData() {
        GetDetail.execute(videoId: String(self.videoId)).then { response -> Promise<Void> in
            self.detailListResponse = response
            
            self.briefView.getModel(model: self.detailListResponse)
            self.contentView.getModel(model: self.detailListResponse)

            return Promise<Void>.resolve()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
