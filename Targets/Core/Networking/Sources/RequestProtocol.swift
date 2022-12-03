import Foundation

public protocol RequestProtocol {
  var host: String { get }
  var path: String { get }
  
  var requestType: RequestType { get }
  
  var header: [String: String] { get }
  var params: [String: Any] { get }
  
  var urlParams: [String: String?] { get }
  
  var authorizationToken: String? { get }
  
}

public extension RequestProtocol {
  var host: String {
    ""
  }
  
  var authorizationToken: String? {
    return nil
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
  func createURLRequest() throws -> URLRequest {
    var components = URLComponents(string: host + path)
    
    if !urlParams.isEmpty {
      components?.queryItems = urlParams.map {
        URLQueryItem(name: $0, value: $1)
      }
    }
    
    guard let url = components?.url else { throw NetworkError.invalidUrl }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue
    
    if !header.isEmpty {
      urlRequest.allHTTPHeaderFields = header
    }
    
    if let authToken = authorizationToken {
      urlRequest.setValue(
        authToken,
        forHTTPHeaderField: "Authorization"
      )
    }
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if !params.isEmpty {
      urlRequest.httpBody = try JSONSerialization.data(
        withJSONObject: params
      )
    }
    
    return urlRequest
  }
}

