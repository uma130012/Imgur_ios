//
//  MainModel.swift
//  GallaryModel
//
//  Created by Uma on 24/12/22.
//

import Foundation
import ObjectMapper

class GallaryModel:Mappable{
    
    var gallaryData : [GallaryData]?
    var success : Bool?
    var status : Int?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        gallaryData <- map["data"]
        success <- map["success"]
        status <- map["status"]
    }
    
    
}

class GallaryData : Mappable {
    var id : String?
    var title : String?
    var description : String?
    var datetime : Int?
    var link : String?
    var is_album : Bool?
    var images : [Images]?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        datetime <- map["datetime"]
        link <- map["link"]
        is_album <- map["is_album"]
        images <- map["images"]
    }
    
}

class Images : Mappable {
    var id : String?
    var title : String?
    var description : String?
    var datetime : Int?
    var type : String?
    var link : String?

    required init?(map: Map) {}

    func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        datetime <- map["datetime"]
        type <- map["type"]
        link <- map["link"]
        
    }

}
