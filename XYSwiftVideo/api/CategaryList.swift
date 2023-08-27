//
//  categarylist.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import Foundation

struct CategaryList {
    
    static func execute() -> Promise<Void> {
        
        return XYNetCore.shared.apiCore(path: CategaryListPath).then { value ->Promise<Void> in
            
            print("")
            return Promise<Void>.resolve()
        }
    }
}
