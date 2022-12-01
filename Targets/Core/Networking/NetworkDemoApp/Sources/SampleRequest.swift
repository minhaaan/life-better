import Foundation
import Networking

enum SampleRequest {
  case posts
}

extension SampleRequest: RequestProtocol {
  var host: String {
    return "jsonplaceholder.typicode.com"
  }
  
  var path: String {
    switch self {
    case .posts:
      return "/posts"
    }
  }
  
  var header: [String : String] {
    return [:]
  }
  
  var params: [String : Any] {
    return [:]
  }
  
  var urlParams: [String : String?] {
    return [:]
  }
  
  var addAuthorizationToken: Bool {
    false
  }
  
  var requestType: Networking.RequestType {
    .GET
  }
}
