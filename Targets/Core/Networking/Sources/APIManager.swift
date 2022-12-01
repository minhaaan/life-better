//
//  APIManager.swift
//  Network
//
//  Created by 최민한 on 2022/12/01.
//  Copyright © 2022 com.minan. All rights reserved.
//

import Foundation
import Combine

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
    
    return urlSession.dataTaskPublisher(for: request)
      .tryMap { data, res in
        try JSONDecoder().decode(👻.self, from: data)
      }
      .eraseToAnyPublisher()
  }
}
