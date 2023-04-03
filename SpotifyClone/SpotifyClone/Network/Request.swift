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
        case get
        case post
        
        var value: String {
            self.rawValue.uppercased()
        }
    }
    
    let path: String
    let querryParameters: [String: String]
    let body: HTTPBodyEncodable?
    let headers: [String: String]
    let method: HTTPMethod
}

struct Network {
    let host: String
    
    func request<T: Decodable>(_ request: Request) async throws -> T {
        let request = urlRequest(from: request)
        let data = try await URLSession.shared.data(for: request)
        
        let jsonDecoder = JSONDecoder()
        let response = try jsonDecoder.decode(T.self, from: data.0)
        
        return response
    }
    
    private func urlRequest(from request: Request) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.path = request.path
        urlComponents.queryItems = request.querryParameters.reduce(into: [], {
            $0.append(.init(name: $1.key, value: $1.value))
        })
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method.value
        urlRequest.allHTTPHeaderFields = request.headers
        if request.method == .post {
            let jsonEncoder = JSONEncoder()
            urlRequest.httpBody = request.body?.encode()
        }
        
        return urlRequest
    }
}
