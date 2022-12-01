import Foundation
import Networking

enum MockRequest {
  case posts
  case mock
}

extension MockRequest: RequestProtocol {
  var host: String {
    return "jsonplaceholder.typicode.com"
  }
  
  var path: String {
    switch self {
    case .posts:
      return "/posts"
    case .mock:
      return "/mock"
    }
  }
  
  var header: [String : String] {
//    switch self {
//    case .posts:
//      return [:]
//    case .mock:
//      return ["key": "value"]
//    }
    return [:]
  }
  
  var params: [String : Any] {
    switch self {
    case .posts:
      return [:]
    case .mock:
      return ["key": "value"]
    }
  }
  
  var urlParams: [String : String?] {
    switch self {
    case .posts:
      return [:]
    case .mock:
      return ["key": "value"]
    }
  }
  
  var requestType: Networking.RequestType {
    switch self {
    case .posts:
      return .GET
    case .mock:
      return .POST
    }
  }
  
  var authorizationToken: String? {
    switch self {
    case .posts:
      return nil
    case .mock:
      return "mock"
    }
  }
}

struct Post: Decodable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}
