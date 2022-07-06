//
//  Constant.swift
//  NousTask
//
//  Created by belal medhat on 06/07/2022.
//

import Foundation
struct Endpoints{
    // base url
    static let baseURL = "https://cloud.nousdigital.net"
    
    // routes url
    static let download = "/s/rNPWPNWKwK7kZcS/download"
}
// MARK: - all headers for url
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
    
}
// MARK: - contentTypes for url

enum ContentType: String {
    case json = "Application/json"
    case formEncode = "application/x-www-form-urlencoded"
}
// MARK: - all parameters status for url
enum RequestParams {
    case body(_:[String:Any])
    case url(_:[String:Any])
    case NoParamter
}
// MARK: - basic request methods for request

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
