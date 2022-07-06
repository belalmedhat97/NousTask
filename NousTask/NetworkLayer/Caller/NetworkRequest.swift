//
//  NetworkRequest.swift
//  NousTask
//
//  Created by belal medhat on 06/07/2022.
//

import Foundation
import Combine
class NetworkRequest{
    static let shared:NetworkRequest = NetworkRequest()
    private let ReqHandler = RequestHandler()
    private init(){}
    
     func getDownload() -> AnyPublisher<DownloadModel, Error> { // identify which network operation to do
        return ReqHandler.run(DownloadRoutes.downloadDetails.urlRequest)
    }
}
