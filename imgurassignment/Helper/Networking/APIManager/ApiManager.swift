//
//  ApiManager.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.

import Foundation
import Alamofire
import ObjectMapper
//enum DataNotFound:Error {
//    case dataNotFound
//}

typealias successs = (Data)-> Void
typealias failure = (Any)-> Void
typealias Response = [String:Any]

func header()->HTTPHeaders{
    return [
        "authorization": "Client-ID 445389195df6224"
    ]
}

class NetworkManager{
    
    private init(){}
    
    static func hitApi<T:Mappable>(
        url:String,
        paramaters:Response = [:],
        httpMethodType:HTTPMethod = .post ,
        headerType:HTTPHeaders = [:],
        success:@escaping(T)-> () ,
        failure: @escaping failure)
    {
        if Connectivity.isNotConnectedToInternet{
            failure(ErrorMessage.Server.checkConnection)
        }
        
        let http = HTTPMethod(rawValue: httpMethodType.rawValue)
        
        print(" ---------- T ** Model  ---------- \n ","\(T.self)")
        print(" ----------  URL  ---------- \n",url)
        print(" ---------- parameters  ---------- \n",paramaters)
        print(" ---------- Header  ---------- \n",header())
        
        AF.request(url,method: http,parameters: paramaters,encoding: httpMethodType.rawValue == "GET" ? URLEncoding() :  JSONEncoding.default, headers: header()).responseData { (response) in
            NetworkManager.dataResponse(response: response) { (res:(T)) in
                success(res)
            } failure: { (error) in
                failure(error)
            }
        }
    }
    
    
    static func dataResponse<T:Mappable>(response:AFDataResponse<Data>,success:@escaping(T)-> () ,failure: @escaping failure){
        print(response.response?.statusCode as Any)
        
        switch response.result{
        case .success(let value):
            do {
                guard let responseDict = try JSONSerialization.jsonObject(with: value) as? Response else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                
                print(" ---------- responseDict  ---------- \n",responseDict)
                guard let item = Mapper<T>.init().map(JSON: responseDict) else{
                    if let error = response.error{
                        failure(error)
                    }
                    return
                }
                print(" ---------- MODEL  ---------- \n",item)
                guard let statusCode = response.response?.statusCode,statusCode == 200 else{
                    if let errorMessage = responseDict["message"] as? String{
                        failure(errorMessage)
                    }
                    return
                }
                
                success(item)
            }catch (let error) {
                print("error *****",error.localizedDescription)
                failure(error)
            }
        case .failure(let error):
            print("error *****",error.localizedDescription)
            failure(error)
        }
    }
}

//func getCurrentTimeZone() -> String{
//    return TimeZone.current.identifier
//}
