//
//  YXDetailViewController.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/13.
//

import UIKit
import SnapKit
import AVFoundation
import AVKit
import HYMedia

let playViewHeight = 220.0 * UIDevice.YH_Width / 390.0

class YXDetailViewController: YXBaseViewController {

    var videoId: Int = 0
    var currentTime: Int = 0
    var detailListResponse: DetailListResponse?
    
    var currentResponse: DetailVideoItemResponse?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var playVideoView: HYVideoPlayView = {
        let view = HYVideoPlayView(frame: .zero)
        view.delegate = self
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
    
    deinit {
        print("YXDetailViewController deinit")
//        self.playVideoView.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        
        getData()
        
        gatherView.clickChangeVideoBack = { [weak self] model in
            guard let self = self else {return}
            
            self.currentResponse = model
            self.defaultNaviTitleLabel.text = (self.detailListResponse?.vod_name ?? "") + "-" + (self.currentResponse?.name ?? "")
            self.playVideoView.startPlayUrl(self.currentResponse?.url ?? "", startPosition: 0)
        }
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
            make.left.top.equalToSuperview()
            make.width.equalTo(UIDevice.YH_Width)
        }
        
        self.scrollView.addSubview(gatherView)
        gatherView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(UIDevice.YH_Width)
            make.top.equalTo(self.briefView.snp_bottom).offset(0)
            make.height.equalTo(180)
        }
        
        self.scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(UIDevice.YH_Width)
            make.top.equalTo(self.gatherView.snp_bottom).offset(0)
            make.bottom.equalTo(self.scrollView.snp_bottom).offset(-15)
        }
    }
    
    func getData() {
        GetDetail.execute(videoId: String(self.videoId)).then { response -> Promise<Void> in
            self.detailListResponse = response
            
            let index = response.vod_play_url.count / 6
            
            if index == 0 {
                self.gatherView.snp.updateConstraints { make in
                    make.height.equalTo(40.0 + 48.0 - 8.0)
                }
            }else {
                self.gatherView.snp.updateConstraints { make in
                    make.height.equalTo(40.0 + 48.0 * Float64(index + 1) - 8.0)
                }
            }

            self.briefView.getModel(model: self.detailListResponse)
            self.contentView.getModel(model: self.detailListResponse)

            if let allKeys = YXDefine.getHistoryAllkeys() as? [String] {
                if allKeys.contains(String(self.videoId)) {
                    
                    let hisArray = YXDefine.getHistory()
                    
                    for item in hisArray {
                        if item.tvId == self.videoId {
                            var r = DetailVideoItemResponse()
                            r.name = item.playName
                            r.url = item.playUrl
                            self.currentResponse = r

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                YXTypeManager.shareInstance().showAd(with: .detail_play) {[weak self] result in
                                    guard let self = self else {return}
                                    DispatchQueue.main.async {
                                        self.playVideoView.startPlayUrl(self.currentResponse?.url ?? "", startPosition: TimeInterval(item.playDuration))
                                    }
                                }
                            }

                            break
                        }
                    }

                }else {
                    //播放第一集
                    self.currentResponse = self.detailListResponse?.vod_play_url.first
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        YXTypeManager.shareInstance().showAd(with: .detail_play) {[weak self] result in
                            guard let self = self else {return}
                            DispatchQueue.main.async {
                                self.playVideoView.startPlayUrl(self.currentResponse?.url ?? "", startPosition: 0)
                            }
                        }
                    }

                }
            }else {
                //播放第一集
                self.currentResponse = self.detailListResponse?.vod_play_url.first
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    
                    YXTypeManager.shareInstance().showAd(with: .detail_play) {[weak self] result in
                        guard let self = self else {return}
                        DispatchQueue.main.async {
                            self.playVideoView.startPlayUrl(self.currentResponse?.url ?? "", startPosition: 0)
                        }
                    }
                }

            }

            self.gatherView.getModel(models: response.vod_play_url, currentModel: self.currentResponse)

            self.defaultNaviTitleLabel.text = (self.detailListResponse?.vod_name ?? "") + "-" + (self.currentResponse?.name ?? "")
            
            return Promise<Void>.resolve()
        }
    }
}

extension YXDetailViewController: HYVideoPlayViewDelegate {
    
    func currentTime(_ currentTime: Int) {
        self.currentTime = currentTime
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        

        let cd = Int(self.playVideoView.currentPosition - 5)
        
        if cd > 10 {
            let model = YXHistoryRecordModel()
            model.tvId = self.videoId
            model.name = self.detailListResponse?.vod_name ?? ""
            model.playUrl = self.currentResponse?.url ?? ""
            model.imageUrl = self.detailListResponse?.vod_pic ?? ""
            model.duration = Int(self.playVideoView.getDuration())
            model.playDuration = Int(self.playVideoView.currentPosition - 5)
            model.playName = self.currentResponse?.name ?? ""
            YXDefine.savePlay(model)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEVIDEOHISTORY"), object: nil, userInfo: nil)
        }
        self.playVideoView.remove()
    }
}
