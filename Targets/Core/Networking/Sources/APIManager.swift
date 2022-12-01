//
//  APIManager.swift
//  Network
//
//  Created by 최민한 on 2022/12/01.
//  Copyright © 2022 com.minan. All rights reserved.
//

import Foundation
import Combine

protocol APIManagerInterface {
  func perform<👻: Decodable>(_ request: RequestProtocol, authToken: String) -> AnyPublisher<👻, Error>
}

class APIManager: APIManagerInterface {
  
  private let urlSession: URLSession
  
  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
  
  func perform<👻: Decodable>(_ request: RequestProtocol, authToken: String) -> AnyPublisher<👻, Error> {
    let a = try? urlSession.dataTaskPublisher(for: request.createURLRequest(authToken: authToken)).eraseToAnyPublisher()
    
    return a!.tryMap() { res in
      guard
        let b = res.response as? HTTPURLResponse,
        b.statusCode == 200
      else {
        throw URLError(.badServerResponse)
      }
      return res.data
    }
    .decode(type: 👻.self, decoder: JSONDecoder())
    .eraseToAnyPublisher()
  }
}
