//
//  CodeChallangeProviding.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import Foundation
import CryptoKit

protocol CodeChallengeProviding {
    /**
     The PKCE authorization flow starts with the creation of a code verifier.
     According to the PKCE standard, a code verifier is a high-entropy cryptographic random string with a length between 43 and 128 characters.
     It can contain letters, digits, underscores, periods, hyphens, or tildes.
     */
    func codeVerifier(length: Int) -> String
    
    /**
     Once the code verifier has been generated, we must transform (hash) it using the SHA256 algorithm.
     This is the value that will be sent within the user authorization request.
     */
    func codeChallenge(codeVerifier: String) -> String?
}

struct CodeChallengeProvider: CodeChallengeProviding {
    func codeVerifier(length: Int) -> String {
        var text = ""
        let possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<possible.count)
            let randomCharacter = possible[possible.index(possible.startIndex, offsetBy: randomIndex)]
            text.append(randomCharacter)
        }
        
        return text
    }
    
    func codeChallenge(codeVerifier: String) -> String? {
        guard let codeVerifierData = codeVerifier.data(using: .utf8) else {
            return nil
        }
        
        let hashData = CryptoKit.SHA256.hash(data: codeVerifierData)
        let digestData = Data(hashData)
        
        return base64encode(digestData)
    }
    
    private func base64encode(_ data: Data) -> String {
        return data.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
