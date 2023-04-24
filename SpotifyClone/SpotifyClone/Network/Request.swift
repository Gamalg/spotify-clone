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

extension Request {
    func toURLRequest(host: String = "accounts.spotify.com") -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        let queryItems: [URLQueryItem] = parameters.reduce(into: [], {
            $0.append(.init(name: $1.key, value: "\($1.value)"))
        })
        
        if method == .GET {
            urlComponents.queryItems = queryItems
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if method == .POST {
            var components = URLComponents()
            components.queryItems = queryItems
            urlRequest.httpBody = components.query?.data(using: .utf8)
        }
        
        return urlRequest
    }
}

struct Network {
    enum Errors: Error {
        case decode
    }
    
    private let host: String = "accounts.spotify.com"
    
    func request<T: Decodable>(_ request: Request) async throws -> T {
        let request = request.toURLRequest()
        print("Request:", request)
        do {
            let data = try await URLSession.shared.data(for: request)
            print("Response:", data.0.prettyPrinted())
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try jsonDecoder.decode(T.self, from: data.0)
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            return response
        } catch {
            print("Decoding error:", error)
            throw Errors.decode
        }
    }
}

fileprivate extension Data {
    func prettyPrinted() -> String {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: .allowFragments)
            let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            return String(data: prettyJsonData, encoding: .utf8) ?? "Failed to pretty print from Data from request"
        } catch {
            return "Failed to pretty print from Data from request. Reason \(error.localizedDescription)"
        }
    }
}
