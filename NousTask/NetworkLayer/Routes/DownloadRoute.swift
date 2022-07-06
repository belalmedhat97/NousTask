//
//  DownloadRoute.swift
//  NousTask
//
//  Created by belal medhat on 06/07/2022.
//

import Foundation
enum DownloadRoutes:APIConfiguration{
    // define the download json route
    case downloadDetails
    
    // configure the base url for download route
    var baseURL: String {
        switch self {
        case.downloadDetails:
            return Endpoints.baseURL
        }
    }
    // configure the path url for download route
    var path: String {
        switch self {
        case.downloadDetails:
            return Endpoints.download
        }
    }
    // configure the parameters for download route
    var parameters: RequestParams {
        switch self {
        case.downloadDetails:
            return.NoParamter
        }
    }
    // configure the request method for download route
    var method: HTTPMethod {
        switch self {
        case.downloadDetails:
            return.get
        }
    }
    // configure the headers for download route
    var Header: [String : String] {
        switch self {
        case.downloadDetails:
            return [:]
        }
    }
    
    
}
