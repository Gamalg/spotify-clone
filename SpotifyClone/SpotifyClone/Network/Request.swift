//
//  Request.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import Foundation

protocol HTTPBodyEncodable {
    func encode() -> Data?
}

extension HTTPBodyEncodable where Self: Encodable {
    func encode() -> Data? {
        do {
            let jsonEncoder = JSONEncoder()
            return try jsonEncoder.encode(self)
        } catch {
            return nil
        }
    }
}

struct Request {
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    /// Must start with /
    let path: String
    let querryParameters: [String: String]
    let body: HTTPBodyEncodable?
    let headers: [String: String]
    let method: HTTPMethod
}

struct Network {
    let host: String = "accounts.spotify.com"
    
    func request<T: Decodable>(_ request: Request) async throws -> T {
        let request = urlRequest(from: request)
        let data = try await URLSession.shared.data(for: request)
        
        let jsonDecoder = JSONDecoder()
        let response = try jsonDecoder.decode(T.self, from: data.0)
        
        return response
    }
    
    private func urlRequest(from request: Request) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = request.path
        urlComponents.queryItems = request.querryParameters.reduce(into: [], {
            $0.append(.init(name: $1.key, value: $1.value))
        })
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        if request.method == .POST {
            urlRequest.httpBody = request.body?.encode()
        }
        
        return urlRequest
    }
}
