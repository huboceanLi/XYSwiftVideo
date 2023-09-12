//
//  RecommendList.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import Foundation
import HandyJSON


struct RecommendResponse: HandyJSON {
    
    var code: Int = 0
    var msg: String = ""
    var time: String = ""

    var data: [RecommendListResponse] = []
}

struct RecommendListResponse: HandyJSON {
    
    var video_id: Int = 0
    var id: Int = 0
    var type_id: Int = 0
    var type_id_1: Int = 0
    var vod_total: Int = 0
    var vod_score_num: Int = 0
    var created_time: Int = 0
    var vod_name: String = ""
    var vod_class: String = ""
    var vod_pic: String = ""
    var vod_blurb: String = ""
    var vod_remarks: String = ""
    var vod_pubdate: String = ""
    var vod_area: String = ""
    var vod_lang: String = ""
    var vod_year: String = ""
    var vod_douban_score: String = ""
    var vod_content: String = ""
    var type_name: String = ""
}

struct RecommendList {
    
    static func execute() -> Promise<[RecommendListResponse]> {
        
        return XYNetCore.shared.apiCore(path: home_recommend).then { value ->Promise<[RecommendListResponse]> in
            
            guard let resp = RecommendResponse.deserialize(from: value) else {
                return Promise<[RecommendListResponse]>.reject(XYNetworkingError.createCommonError())
            }
            return Promise<[RecommendListResponse]>.resolve(resp.data)
        }
    }
}
