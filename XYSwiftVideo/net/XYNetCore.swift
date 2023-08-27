//
//  XYNetCore.swift
//  XYSwiftVideo
//
//  Created by Ocean 李 on 2023/8/27.
//

import UIKit
import Alamofire

class XYNetCore: NSObject {

    public static let shared = XYNetCore()
    var sessionManager: Alamofire.SessionManager

    private override init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60  // Timeout interval
        config.httpMaximumConnectionsPerHost = 50
        sessionManager = SessionManager(configuration: config)
    }
    
    public func apiCore(path: String,
                        method: HTTPMethod = .post,
                        parameters: [String : Any]? = nil) -> Promise<String> {
        
        let promiss = Promise<String> {[weak self] (resolve, reject) in
            guard let self = self else { return }
            
            self.sessionManager.request(path,
                                   method: method,
                                   parameters: parameters,
                                   encoding: JSONEncoding.default,
                                        headers: nil).responseJSON { response in
                self.requestLog(netUrl: path, method: method, parameters: parameters, respon: response)
                
                if response.result .isFailure {
                    let error = XYNetworkingError(netError:YXNetError.NO_NETWORKING)
                    reject(error)
                    return
                }
                
                guard let jsonDic = response.result.value as? [String: Any] else {
                    let error = XYNetworkingError(netError:YXNetError.NO_NETWORKING)
                    reject(error)
                    return
                }
                
                let code = jsonDic["code"] as? Int
                let msg = jsonDic["msg"] as? String
                
                if  code == 1 {
                    if let data = jsonDic["data"], data is NSNull {
                        resolve("")
                        return
                    }
                    
                    guard let data = jsonDic["data"] else {
                        resolve("")
                        return
                    }
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
                    guard let jData = jsonData, let str = String(data: jData, encoding: .utf8) else {
                        resolve("")
                        return
                    }
                    
                    resolve(str)
                    return
                } else {
                    let error = XYNetworkingError(netError:YXNetError.NO_NETWORKING)
                    reject(error)
                    return
                }
            }
            
        }
        
        return promiss

    }
    
    
    // MARK: -
    func requestLog(netUrl: String,
                    method: HTTPMethod,
                    parameters: [String: Any]?,
                    respon: DataResponse<Any>?) {
        
                                       
        DispatchQueue.global().async {
            
            var log = "\n=============================================================================\n\n"
            log += "URL:               \(netUrl)\n"
            log += "Method:            \(method.rawValue)\n"
            log += "Parameters:        \(parameters ?? [:])\n"
            log += "\n*****************************************************************************\n\n"
            if let value = respon?.value {
                log += "\(value)\n"
            }
            if let error = respon?.error {
                log += "\(error)\n"
            }
            log += "\n=============================================================================\n"
            
            print(log)
        }

    }
}
