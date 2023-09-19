//
//  GetDetail.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import Foundation
import HandyJSON

struct DetailResponse: HandyJSON {
    
    var code: Int = 0
    var msg: String = ""
    var time: String = ""

    var data: DetailListResponse?
}

struct DetailListResponse: HandyJSON {
    
    var id: Int = 0
    var vod_id: Int = 0
    var type_id: Int = 0
    var type_id_1: Int = 0
    var vod_total: Int = 0
    var vod_name: String = ""
    var vod_sub: String = ""
    var vod_class: String = ""
    var vod_pic: String = ""
    var vod_actor: String = ""
    var vod_director: String = ""
    var vod_writer: String = ""
    var vod_blurb: String = ""
    var vod_remarks: String = ""
    var vod_pubdate: String = ""
    var vod_area: String = ""
    var vod_lang: String = ""
    var vod_year: String = ""
    var vod_author: String = ""
    var vod_content: String = ""
    var type_name: String = ""
    var vod_douban_score: String = ""
    var vod_play_url: [DetailVideoItemResponse] = []
}

struct DetailVideoItemResponse: HandyJSON {
    
    var name: String = ""
    var url: String = ""
}

struct GetDetail {
    
    static func execute(videoId: String) -> Promise<DetailListResponse> {
        
        let url = video_detail + "?id=" + videoId

        let newUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        return XYNetCore.shared.apiCore(path: newUrl,parameters: nil).then { value ->Promise<DetailListResponse> in
            
            guard let resp = DetailResponse.deserialize(from: value) else {
                return Promise<DetailListResponse>.reject(XYNetworkingError.createCommonError())
            }
            
            guard let re = resp.data else {
                return Promise<DetailListResponse>.reject(XYNetworkingError.createCommonError())
            }
            
            return Promise<DetailListResponse>.resolve(re)
        }
    }
}
