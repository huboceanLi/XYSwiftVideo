//
//  categarylist.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import Foundation
import HandyJSON

struct CategaryResponse: HandyJSON {
    
    var code: Int = 0
    var data: [CategaryListResponse] = []
}

struct CategaryListResponse: HandyJSON {
    
    var id: Int = 0
    var name: String = ""
    var order: [String] = []
    var type: [CategaryListItemResponse] = []
    var vod_year: [String] = []
    var vod_area: [String] = []
    var vod_lang: [String] = []
}

struct CategaryListItemResponse: HandyJSON {
    
    var id: Int = 0
    var name: String = ""
}

struct CategaryList {
    
    static func execute() -> Promise<[CategaryListResponse]> {
        
        return XYNetCore.shared.apiCore(path: CategaryListPath).then { value ->Promise<[CategaryListResponse]> in
            
            guard let resp = CategaryResponse.deserialize(from: value) else {
                return Promise<[CategaryListResponse]>.reject(XYNetworkingError.createCommonError())
            }
            return Promise<[CategaryListResponse]>.resolve(resp.data)
        }
    }
}
