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

struct EmptyResponse: Decodable {}

protocol Request {
    associatedtype ResponseType
    /// Must start with /
    var path: String { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var neededAuth: Bool { get }
    
    func decode(_ data: Data) throws -> ResponseType
}

extension Request where ResponseType: Decodable {
    func decode(_ data: Data) throws -> ResponseType {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(ResponseType.self, from: data)
    }
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
    
    private let host: String
    private let tokenStorage: TokenStorage = .live
    
    init(host: String = "api.spotify.com") {
        self.host = host
    }
    
    func request<T: Request>(_ request: T) async throws -> T.ResponseType {
        var urlRequest = request.toURLRequest(host: host)
        if request.neededAuth {
            await addAuthHeaders(request: &urlRequest)
        }

        print("Request:", urlRequest)

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            print("Response:", data.prettyPrinted())
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try request.decode(data)
            
            // TODO: Add error handler
            
            return response
        } catch {
            print("Decoding error:", error)
            throw Errors.decode
        }
    }
    
    private func addAuthHeaders(request: inout URLRequest) async {
        guard let token = tokenStorage.get() else {
            // TODO: Show Authorization screen
            return
        }

        guard token.hasTokenExpired else {
            request.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
            return
        }

        let refreshTokenRequest = RefreshTokenRequest(refreshToken: token.refreshToken)
        do {
            let tokenDTO: TokenRequestResponse = try await self.request(refreshTokenRequest)
            let newToken = tokenDTO.toDomain()
            try tokenStorage.set(newToken)
            request.addValue("Bearer \(newToken.accessToken)", forHTTPHeaderField: "Authorization")
        } catch {
            // TODO: Show Authorization screen
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
            return "Failed to pretty print from Data from request. Reason: \(error.localizedDescription).\nData: \(String(data: self, encoding: .utf8))"
        }
    }
}
