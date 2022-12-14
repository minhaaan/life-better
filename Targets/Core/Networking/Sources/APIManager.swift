//
//  APIManager.swift
//  Network
//
//  Created by μ΅λ―Όν on 2022/12/01.
//  Copyright Β© 2022 com.minan. All rights reserved.
//

import Foundation
import Combine
import Utils

public protocol APIManagerInterface {
  func perform<π»: Decodable>(_ request: RequestProtocol, type: π».Type) -> AnyPublisher<π», Error>
}

public class APIManager: APIManagerInterface {
  
  private let urlSession: URLSession
  
  public init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
  
  public func perform<π»: Decodable>(_ request: RequestProtocol, type: π».Type) -> AnyPublisher<π», Error> {
    guard let request = try? request.createURLRequest() else {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    log.verbose("Networking: Request url is \(request.url!)")
    
    return urlSession.dataTaskPublisher(for: request.url!)
      .tryMap() { element -> Data in
        log.verbose("Networking: Response statusCode is \((element.response as? HTTPURLResponse)?.statusCode) request url: \(request.url!)")
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        return element.data
      }
      .decode(type: π».self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
