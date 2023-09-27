//
//  YXGatherView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/19.
//

import UIKit
import SnapKit

let gatherCellWidth = (UIDevice.YH_Width - 6.0 * leftSpace) / 5.0
let gatherCellHeight = 40.0

class YXGatherView: UIView {
    
    var vodPlayUrls: [DetailVideoItemResponse] = []
    var isMore = false

    lazy var titleLab: UILabel = {
        let lbl: UILabel = UILabel.init(frame: .zero)
        lbl.textAlignment = .left
        lbl.text = "选集"
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = UIColor.color0D1324()
        return lbl
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: leftSpace, bottom: 0, right: leftSpace)
        layout.itemSize = CGSize(width: gatherCellWidth - 1.0, height: gatherCellHeight)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(YXGatherCell.classForCoder(), forCellWithReuseIdentifier: NSStringFromClass(YXGatherCell.classForCoder()))
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        self.backgroundColor = UIColor.white
        
        self.addSubview(titleLab)

        titleLab.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(15)
            make.width.equalTo(UIDevice.YH_Width - 30.0)
            make.top.equalTo(self.snp_top).offset(0)
            make.height.equalTo(40)
        }
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.titleLab.snp_bottom).offset(0)
        }
    }

    func getModel(models: [DetailVideoItemResponse], isMore: Bool) {
        self.vodPlayUrls = models
        self.isMore = isMore
        self.collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YXGatherView: UICollectionViewDelegate, UICollectionViewDataSource {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.vodPlayUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(YXGatherCell.classForCoder()), for: indexPath) as? YXGatherCell else { return UICollectionViewCell() }
        cell.backgroundColor = UIColor.color8F9BAF().withAlphaComponent(0.1)
        
        cell.name.text = self.vodPlayUrls[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
}
