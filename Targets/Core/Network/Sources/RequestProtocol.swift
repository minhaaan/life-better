import Foundation

protocol RequestProtocol {
  var path: String { get }
  
  var header: [String: String] { get }
  var params: [String: Any] { get }
  
  var urlParams: [String: String?] { get }
  
  var addAuthorizationToken: Bool { get }
  
  var requestType: RequestType { get }
}

extension RequestProtocol {
  var host: String {
    ""
  }
  
  var addAuthorizationToken: Bool {
    return true
  }
  
  var params: [String: Any] {
    [:]
  }
  
  var urlParams: [String: String?] {
    [:]
  }
  
  var headers: [String: String] {
    [:]
  }
}

extension RequestProtocol {
  func createURLRequest(authToken: String) throws -> URLRequest {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    
    if !urlParams.isEmpty {
      components.queryItems = urlParams.map {
        URLQueryItem(name: $0, value: $1)
      }
    }
    
    guard let url = components.url else { throw NetworkError.invalidUrl }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue
    
    if !header.isEmpty {
      urlRequest.allHTTPHeaderFields = header
    }
    
    if addAuthorizationToken {
      urlRequest.setValue(
        authToken,
        forHTTPHeaderField: "Authorization"
      )
    }
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if !params.isEmpty {
      urlRequest.httpBody = try JSONSerialization.data(
        withJSONObject: path
      )
    }
    
    return urlRequest
  }
}
