//
//  APIConstants.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

struct BaseURLS {
    
    static let baseURL = "https://android-ios-service.herokuapp.com"
    
    enum PathsConstant: String {
        case transactions = "/transactions"
        case rates = "/rates"
    }
    
    func getURLStringByPath(path: PathsConstant) -> String {
       return BaseURLS.baseURL + path.rawValue
    }

}
