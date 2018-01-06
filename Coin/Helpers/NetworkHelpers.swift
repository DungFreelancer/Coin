//
//  NetworkHelper.swift
//  TemplateProject
//
//  Created by Tran Gia Huy on 10/4/17.
//  Copyright © 2017 HD. All rights reserved.
//

import Alamofire
import SwiftyJSON

class NetworkHelper {
    
    static let sharedInstance = NetworkHelper ()
    private let reachabilityManager = NetworkReachabilityManager()
    var isConnect: Bool? {
        return NetworkReachabilityManager()?.isReachable
    }
    
    private init() {}
    
    func connectingChange(_ connected: @escaping (Bool)->()) {
        reachabilityManager?.listener = { status in
            if (status != .unknown && status != .notReachable) {
                connected(true)
            } else {
                connected(false)
            }
        }
        reachabilityManager?.startListening()
    }
    
    func get(url: String, complete:((_ success: JSON?,_ error: Error?)->())?) {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let complete = complete {
                    complete(json, nil)
                }
            case .failure(let error):
                if let complete = complete {
                    complete(nil, error)
                }
            }
        }
    }
    
}
