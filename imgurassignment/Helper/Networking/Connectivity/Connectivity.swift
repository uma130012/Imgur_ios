//
//  Connectivity.swift
//  FPSJobs
//
//  Created by UMA on 12/12/22.
//

import Foundation
import Alamofire
class Connectivity {
    static var isNotConnectedToInternet:Bool{
        return !NetworkReachabilityManager()!.isReachable
    }
}
