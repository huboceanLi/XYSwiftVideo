//
//  YXMainRecommendView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/11.
//

import UIKit
import JXPagingView
import SnapKit

let space = 8.0
let leftSpace = 15.0
let count = 3
let cellWidth = (UIDevice.YH_Width - leftSpace * 2 - space * 2) / Double(count) - 1.0
let cellHeight = 160.0 * cellWidth / 120.0 + 6.0 + 20.0
let headViewHeight = 44.0

class YXMainRecommendView: UIView {


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
        
        collectionView.register(YXMainRecommendCell.classForCoder(), forCellWithReuseIdentifier: NSStringFromClass(YXMainRecommendCell.classForCoder()))
        
        collectionView.register(YXMainRecommendHeadView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")

        
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
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

extension YXMainRecommendView: JXPagingViewListViewDelegate {

    func listView() -> UIView { self }

    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        listViewDidScrollCallback = callback
    }
    
    
    func listScrollView() -> UIScrollView { collectionView }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listViewDidScrollCallback?(scrollView)
    }
}

extension YXMainRecommendView: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(YXMainRecommendCell.classForCoder()), for: indexPath) as? YXMainRecommendCell else { return UICollectionViewCell() }
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    
    
}

extension YXMainRecommendView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! YXMainRecommendHeadView

        header.showTitle(index: indexPath.section, dic: self.dataDic)
        
        return header
    }
    
}

