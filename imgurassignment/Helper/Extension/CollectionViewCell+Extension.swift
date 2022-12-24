//
//  CollectionViewCell+Extension.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.
//

import Foundation
import  UIKit

extension UICollectionViewCell{
    static var reuseID:String{
       return String(describing: self)
    }
}
