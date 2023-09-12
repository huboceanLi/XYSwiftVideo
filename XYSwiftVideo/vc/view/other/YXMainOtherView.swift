//
//  YXMainOtherView.swift
//  XYSwiftVideo
//
//  Created by oceanMAC on 2023/9/11.
//

import UIKit
import JXPagingView

class YXMainOtherView: UIView {

    var index: Int = 0
    var categeryModel: CategaryListResponse!
    
    
    lazy var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)

    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeUI()
    }

    func initializeUI() {
        
        self.backgroundColor = UIColor.clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YXMainOtherView: JXPagingViewListViewDelegate {

    func listView() -> UIView { self }

    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        listViewDidScrollCallback = callback
    }
    
    
    func listScrollView() -> UIScrollView { tableView }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listViewDidScrollCallback?(scrollView)
    }
}
