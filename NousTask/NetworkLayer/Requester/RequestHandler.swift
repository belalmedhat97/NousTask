//
//  RequestHandler.swift
//  NousTask
//
//  Created by belal medhat on 06/07/2022.
//

import Foundation
import Combine
struct HTTPResponse<T> {
    let value: T
    let response: URLResponse
}

struct RequestHandler {
     func Request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<HTTPResponse<T>, Error> {
        return URLSession(configuration: .default).dataTaskPublisher(for: request)
            .retry(3)
            .tryMap { result -> HTTPResponse<T> in
                let ResponseDecoder = try JSONDecoder().decode(T.self, from: result.data)
                return HTTPResponse(value: ResponseDecoder, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    func run<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, Error> { // performer of all network calls
        return Request(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
