//
//  IntExtension.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.
//

import Foundation
import UIKit

extension Int{
    func timeStampToTime() -> String{
        let epocTime = TimeInterval(self)
        let myDate = Date(timeIntervalSince1970: epocTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd/MM/YY hh:mm a"
        let localTime = dateFormatter.string(from: myDate)
//        print(localTime)
        return localTime
    }
}
