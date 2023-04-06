//
//  Request.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

protocol Request {
    /// Must start with /
    var path: String { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
}

struct Network {
    enum Errors: Error {
        case decode
    }
    let host: String = "accounts.spotify.com"
    
    func request<T: Decodable>(_ request: Request) async throws -> T {
        let request = urlRequest(from: request)
        print("Request:", request)
        do {
            let data = try await URLSession.shared.data(for: request)
            print("Response:", String(data: data.0, encoding: .utf8))
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try jsonDecoder.decode(T.self, from: data.0)
            return response
        } catch {
            print("Decoding error:", error)
            throw Errors.decode
        }
    }
    
    func urlRequest(from request: Request) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = request.path
        
        let queryItems: [URLQueryItem] = request.parameters.reduce(into: [], {
            $0.append(.init(name: $1.key, value: "\($1.value)"))
        })
        
        if request.method == .GET {
            urlComponents.queryItems = queryItems
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if request.method == .POST {
            var components = URLComponents()
            components.queryItems = queryItems
            urlRequest.httpBody = components.query?.data(using: .utf8)
        }
        
        return urlRequest
    }
}
