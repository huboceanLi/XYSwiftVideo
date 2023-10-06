//
//  SearchMovies.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import Foundation
import HandyJSON

struct SearchRequest: HandyJSON {
    
    var page: Int = 0
    var keywords: String = ""
}

struct SearchMovies {
    
    static func execute(keywords: String, page: Int) -> Promise<[RecommendListResponse]> {
        
//        let request = SearchRequest(page: 1, keywords: "222")
//        let param = SearchRequest.toJSON(request)()

        let url = home_search + "?keywords=" + keywords + "&page=" + String(page)

        let newUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        return XYNetCore.shared.apiCore(path: newUrl,parameters: nil).then { value ->Promise<[RecommendListResponse]> in
            
            guard let resp = RecommendResponse.deserialize(from: value) else {
                return Promise<[RecommendListResponse]>.reject(XYNetworkingError.createCommonError())
            }
            return Promise<[RecommendListResponse]>.resolve(resp.data)
        }
    }
}
