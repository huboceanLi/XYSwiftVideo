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
        
    var detailListResponse: DetailListResponse?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var playVideoView: HYVideoPlayView = {
        let view = HYVideoPlayView(frame: CGRectMake(0, 88, UIDevice.YH_Width, playViewHeight))
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
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
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
//        playVideoView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
//            make.height.equalTo(playViewHeight)
//        }
        
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
        
        // 创建 AVPlayer
//               guard let url = URL(string: "https://ukzyvod3.ukubf5.com/20230728/gX3uVgyX/index.m3u8") else {
//                   return
//               }
//               player = AVPlayer(url: url)
//
//               // 创建 AVPlayerLayer 并添加到视图中
//               playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = CGRect(x: 0, y: 0, width: UIDevice.YH_Width, height: playViewHeight)
//        playVideoView.layer.addSublayer(playerLayer)
//
//               // 播放视频
//               player.play()
    }
    
    func getData() {
        GetDetail.execute(videoId: String(self.videoId)).then { response -> Promise<Void> in
            self.detailListResponse = response
            
            var vodPlayUrls: [DetailVideoItemResponse] = []
            
            
            
            
            if response.vod_play_url.count > 10 {
                for index in 0..<response.vod_play_url.count {
                    if index < 9 {
                        vodPlayUrls.append(response.vod_play_url[index])
                    }
                }
                self.gatherView.getModel(models: vodPlayUrls, isMore: true)
                self.gatherView.snp.updateConstraints { make in
                    make.height.equalTo(40.0 + 48.0 * 2.0 - 8.0)
                }
            }else {
                vodPlayUrls = response.vod_play_url
                self.gatherView.getModel(models: vodPlayUrls, isMore: false)
                
                if response.vod_play_url.count < 5 {
                    self.gatherView.snp.updateConstraints { make in
                        make.height.equalTo(40.0 + 40.0)
                    }
                }else {
                    self.gatherView.snp.updateConstraints { make in
                        make.height.equalTo(40.0 + 48.0 * 2.0 - 8.0)
                    }
                }

            }
            

            
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
