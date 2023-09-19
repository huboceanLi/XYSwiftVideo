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
        

    
    private lazy var playVideoView: YXPlayVideoView = {
        let view = YXPlayVideoView(frame: .zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
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
