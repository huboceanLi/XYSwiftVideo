//
//  YXHistoryRecordModel.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/10/3.
//

import Foundation
import YYModel

@objcMembers public class YXHistoryRecordModel: NSObject {
    
    public var tvId: Int = 0
    public var name: String = ""
    public var playUrl: String = ""
    public var imageUrl: String = ""
    public var duration: Int = 0 //总时间
    public var playDuration: Int = 0 //100秒
    public var playName: String = "" //第三集
    public var creatTime: Int = 0 //

}
