//
//  SignInViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import Foundation
import CryptoKit

protocol SignInViewModelProtocol {
    func auth()
}

class SignInViewModel: NSObject, SignInViewModelProtocol {
    lazy var codeVerifier = generateRandomString(length: 53)
    lazy var codeChallenge: String = {
        do {
            return try generateCodeChallenge(codeVerifier: codeVerifier)
        } catch {
            return ""
        }
    }()
    
    lazy var state = generateRandomString(length: 16)
    let network = Network()
    
    func auth() {
    }
    
    func authorize() -> String {
        let authorize = AuthorizeRequest(state: state, codeChallenge: codeChallenge)
        return network.urlRequest(from: authorize).url?.absoluteString ?? ""
    }
    
    func authRequest(code: String, redirectUri: URL) async throws -> Token {
        let request = TokenRequest(code: code, codeVerifier: codeVerifier, redirectUri: redirectUri.absoluteString)
        let token: Token = try await network.request(request)
        TokenStorage.live.set(token)

        return token
    }

    private func generateRandomString(length: Int) -> String {
        var text = ""
        let possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<possible.count)
            let randomCharacter = possible[possible.index(possible.startIndex, offsetBy: randomIndex)]
            text.append(randomCharacter)
        }
        
        return text
    }

    private func generateCodeChallenge(codeVerifier: String) throws -> String {
      func base64encode(_ data: Data) -> String {
        return data.base64EncodedString()
          .replacingOccurrences(of: "+", with: "-")
          .replacingOccurrences(of: "/", with: "_")
          .replacingOccurrences(of: "=", with: "")
      }

      guard let codeVerifierData = codeVerifier.data(using: .utf8) else {
        throw NSError(domain: "Invalid code verifier", code: 0)
      }

      let hashData = CryptoKit.SHA256.hash(data: codeVerifierData)
      let digestData = Data(hashData)
      
      return base64encode(digestData)
    }
}
