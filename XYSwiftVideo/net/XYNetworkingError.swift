//
//  XYNetworkingError.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import UIKit

enum YXNetError : Int {
    case NO_NETWORKING = -1009
    case COMMON_ERROR = 501
}

class XYNetworkingError: Error {

    /// error code
    @objc var code = -1
    /// error description
    @objc var localizedDescription: String
    
    init(code: Int, desc: String) {
        self.code = code
        self.localizedDescription = desc
    }
    
    init(netError : YXNetError) {
        self.code = netError.rawValue
        switch netError {
        case .NO_NETWORKING:
//            let err = TMMSwiftOcBridge.shared.localized(key: R.string.localize.net_something.key) ?? ""
            self.localizedDescription = "Network Error,Please try again"
        default:
            self.localizedDescription = "Network Error,Please try again"
            return
        }
    }
    
    static func createCommonError() -> XYNetworkingError {
        return XYNetworkingError.init(netError: YXNetError.COMMON_ERROR)
    }
}
