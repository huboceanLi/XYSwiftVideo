//
//  YXMainViewController.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import UIKit
import JXPagingView
import JXSegmentedView
import SnapKit

extension JXPagingListContainerView: JXSegmentedViewListContainer {}


@objcMembers public class YXMainViewController: YXBaseViewController  {

    var titles = ["能力", "爱好", "队友"]
    let dataSource: JXSegmentedTitleDataSource = JXSegmentedTitleDataSource()
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: .zero)

    private lazy var pagingView: JXPagingView = {
        let view = JXPagingView(delegate: self)
//        view.mainTableView.gestureDelegate = self
//        view.pinSectionHeaderVerticalOffset = Int(UIDevice.YH_Nav_Height)
        view.listContainerView.scrollView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        view.mainTableView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
//        self.cusNaviBar.qmui_borderPosition = QMUIViewBorderPosition.bottom
//        self.cusNaviBar.qmui_borderColor = .clear
//        self.cusNaviBar.qmui_borderWidth = IMDefine.seperateLineHeight()
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        self.cusNaviBar.backgroundColor = .clear
        self.view.backgroundColor = UIColor.colorEFF0F3()
        
        dataSource.titles = titles
        dataSource.titleSelectedColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
        dataSource.titleNormalColor = UIColor.black
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isTitleZoomEnabled = true

        segmentedView.backgroundColor = UIColor.clear
        segmentedView.delegate = self
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false
        segmentedView.dataSource = dataSource
        segmentedView.listContainer = pagingView.listContainerView

//        let lineView = JXSegmentedIndicatorLineView()
//        lineView.indicatorColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
//        lineView.indicatorWidth = 30
//        segmentedView.indicators = [lineView]

//        let lineWidth = 1/UIScreen.main.scale
//        let bottomLineView = UIView()
//        bottomLineView.backgroundColor = UIColor.lightGray
//        bottomLineView.frame = CGRect(x: 0, y: segmentedView.bounds.height - lineWidth, width: segmentedView.bounds.width, height: lineWidth)
//        bottomLineView.autoresizingMask = .flexibleWidth
//        segmentedView.addSubview(bottomLineView)

        pagingView.mainTableView.gestureDelegate = self
        pagingView.backgroundColor = UIColor.clear
        pagingView.listContainerView.listCellBackgroundColor = UIColor.clear
        pagingView.mainTableView.backgroundColor = UIColor.clear
        self.view.addSubview(pagingView)
        
        pagingView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
        }
        
//        self.segmentedView.snp_updateConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
//            make.height.equalTo(44)
//        }
        
        
//        CategaryList.execute()
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

extension YXMainViewController: JXPagingMainTableViewGestureDelegate {
    
    public func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer == self.segmentedView.collectionView.panGestureRecognizer {
            return false
        }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
}

extension YXMainViewController: JXSegmentedViewDelegate {
    
    
}


extension YXMainViewController: JXPagingViewDelegate {
    
    public func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return 0
    }
    
    public func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return UIView()
    }
    
    public func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return 44
    }
    
    public func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return self.segmentedView
    }
    
    public func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }
    
    public func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        
        let view = YXMainRecommendView()
        return view
        
    }
}
