//
//  SignInViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import Foundation
import SpotifyiOS
import CryptoKit

protocol SignInViewModelProtocol {
    func auth()
}

class SignInViewModel: NSObject, SignInViewModelProtocol {
    let spotifyClientID = "d5266d28457741dc81d9b8172ff32bd5"
    let spotifyRedirectURL = URL(string: "g-spotify://g-spotify-callback")
    lazy var configuration = SPTConfiguration(
      clientID: spotifyClientID,
      redirectURL: spotifyRedirectURL!
    )
    
    lazy var manager = SPTSessionManager(configuration: configuration, delegate: self)
    lazy var appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
    
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
        manager.initiateSession(with: .appRemoteControl)
    }
    
    func authorize() -> String {
        let authorize = AuthorizeRequest(state: state, codeChallenge: codeChallenge)
        return network.urlRequest(from: authorize).url?.absoluteString ?? ""
    }
    
    func authRequest(code: String, redirectUri: URL) {
        let params = appRemote.authorizationParameters(from: redirectUri)
        Task {
            let request = TokenRequest(code: code, codeVerifier: codeVerifier, redirectUri: redirectUri.absoluteString)
            let token: Token? = try await network.request(request)
        }
    }
    
    func generateRandomString(length: Int) -> String {
      var text = ""
      let possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

      for _ in 0..<length {
        let randomIndex = Int.random(in: 0..<possible.count)
        let randomCharacter = possible[possible.index(possible.startIndex, offsetBy: randomIndex)]
        text.append(randomCharacter)
      }

      return text
    }

    func generateCodeChallenge(codeVerifier: String) throws -> String {
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

extension SignInViewModel: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("didInitiate session:", session.accessToken)
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print(error)
    }
}
