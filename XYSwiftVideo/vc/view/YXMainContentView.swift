//
//  YXMainContentView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/11.
//

import UIKit
import SnapKit
import YYWebImage

let space = 8.0
let leftSpace = 15.0
let count = 3
let cellWidth = (UIDevice.YH_Width - leftSpace * 2 - space * 2) / Double(count) - 1.0
let cellHeight = 160.0 * cellWidth / 120.0 + 6.0 + 20.0
let headViewHeight = 44.0

class YXMainContentView: UIView {

    var dataDic: [String: [RecommendListResponse]] = [:]
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: leftSpace, bottom: 0, right: leftSpace)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.headerReferenceSize = CGSize(width: UIDevice.YH_Width, height: headViewHeight)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(YXMainCell.classForCoder(), forCellWithReuseIdentifier: NSStringFromClass(YXMainCell.classForCoder()))
        collectionView.register(YXMainHeadView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
        getData()
    }

    func initializeUI() {
        
        self.backgroundColor = UIColor.clear
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func getData() {
        self.dataDic.removeAll()
        
        RecommendList.execute().then { responseObject ->Promise<Void> in

            for item in responseObject {
                
                let tid = String(item.type_id_1)
                
                let keys = Array(self.dataDic.keys)
                if keys.contains(tid) {
                    var itemArr: [RecommendListResponse] = []
                    if let a = self.dataDic[tid] {
                        itemArr = a
                    }
                    itemArr.append(item)
                    self.dataDic[tid] = itemArr
                }else {
                    self.dataDic[tid] = [item]
                }
            }
            self.collectionView.reloadData()
            return Promise<Void>.resolve()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension YXMainContentView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let keys = Array(self.dataDic.keys)

        return keys.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let keys = Array(self.dataDic.keys)
        if keys.contains("1"), section == 0 { //电影
            if let a = self.dataDic["1"] {
                return a.count
            }
            return 0
        }
        if keys.contains("2"), section == 1 { //电视剧
            if let a = self.dataDic["2"] {
                return a.count
            }
            return 0
        }
        if keys.contains("3"), section == 2 { //综艺
            if let a = self.dataDic["3"] {
                return a.count
            }
            return 0
        }
        if keys.contains("4"), section == 3 { //动漫
            if let a = self.dataDic["4"] {
                return a.count
            }
            return 0
        }
        if keys.contains("24"), section == 4 { //记录片
            if let a = self.dataDic["24"] {
                return a.count
            }
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(YXMainCell.classForCoder()), for: indexPath) as? YXMainCell else { return UICollectionViewCell() }
        cell.backgroundColor = UIColor.clear
        cell.scoreLab.isHidden = true

        let keys = Array(self.dataDic.keys)
        
        var modelArr: [RecommendListResponse] = []
        if keys.contains("1"), indexPath.section == 0 { //电影
            
            if let arr = self.dataDic["1"] {
                modelArr = arr
            }
        }
        
        if keys.contains("2"), indexPath.section == 1 {
            
            if let arr = self.dataDic["2"] {
                modelArr = arr
            }
        }
        
        if keys.contains("3"), indexPath.section == 2 {
            
            if let arr = self.dataDic["3"] {
                modelArr = arr
            }
        }
        
        if keys.contains("4"), indexPath.section == 3 {
            
            if let arr = self.dataDic["4"] {
                modelArr = arr
            }
        }
        if keys.contains("24"), indexPath.section == 4 {
            
            if let arr = self.dataDic["24"] {
                modelArr = arr
            }
        }
        if let item = modelArr[indexPath.row] as? RecommendListResponse {
            cell.headImageView.yy_setImage(with: URL(string: item.vod_pic), placeholder: UIImage.xy_bundleImage(name: "uk_image_fail"))
            cell.name.text = item.vod_name
            cell.des.text = item.vod_remarks

            if let s = Double(item.vod_douban_score) {
                if s >= 7.0 {
                    cell.scoreLab.isHidden = false
                    cell.scoreLab.text =  item.vod_douban_score
                }
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let keys = Array(self.dataDic.keys)
        
        var modelArr: [RecommendListResponse] = []
        if keys.contains("1"), indexPath.section == 0 { //电影
            
            if let arr = self.dataDic["1"] {
                modelArr = arr
            }
        }
        
        if keys.contains("2"), indexPath.section == 1 {
            
            if let arr = self.dataDic["2"] {
                modelArr = arr
            }
        }
        
        if keys.contains("3"), indexPath.section == 2 {
            
            if let arr = self.dataDic["3"] {
                modelArr = arr
            }
        }
        
        if keys.contains("4"), indexPath.section == 3 {
            
            if let arr = self.dataDic["4"] {
                modelArr = arr
            }
        }
        if keys.contains("24"), indexPath.section == 4 {
            
            if let arr = self.dataDic["24"] {
                modelArr = arr
            }
        }
        
        if let item = modelArr[indexPath.row] as? RecommendListResponse {
            
            YXTypeManager.shareInstance().showAd(with: .detail_touch) { result in
                DispatchQueue.main.async {
                    if result {
                        YXDefine.saveJLADKey(true)
                        let vc = YXDetailViewController()
                        vc.videoId = item.video_id
                        YXPagePushUtil.pushToViewController(vc: vc, isAnimated: true)
                    }else {
                        let alertController = UIAlertController(title: "",
                                        message: "看完视频可以获取所有视频观看权限!", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                            action in

                        })
                        alertController.addAction(cancelAction)
                        alertController.addAction(okAction)
                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                }
            }

        }
    }
}

extension YXMainContentView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! YXMainHeadView

        header.showTitle(index: indexPath.section, dic: self.dataDic)
        
        return header
    }
    
}

