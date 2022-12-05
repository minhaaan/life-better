//
//  APIManager.swift
//  Network
//
//  Created by 최민한 on 2022/12/01.
//  Copyright © 2022 com.minan. All rights reserved.
//

import Foundation
import Combine
import Utils

public protocol APIManagerInterface {
  func perform<👻: Decodable>(_ request: RequestProtocol, type: 👻.Type) -> AnyPublisher<👻, Error>
}

public class APIManager: APIManagerInterface {
  
  private let urlSession: URLSession
  
  public init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
  
  public func perform<👻: Decodable>(_ request: RequestProtocol, type: 👻.Type) -> AnyPublisher<👻, Error> {
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
      .decode(type: 👻.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
