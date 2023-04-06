//
//  WebView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import Foundation
import SwiftUI
import Combine
import WebKit
import UIKit

enum URLType {
    case local, `public`
}

struct WebView: UIViewRepresentable {
    @Environment(\.dismiss) var dismiss
    
    var type: URLType
    var url: URL
    
    let signInViewModel: SignInViewModel
        
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.setURLSchemeHandler(
            GSpotifySchemeHandler(signInViewModel: signInViewModel, completion: completion), forURLScheme: GlobalConstants.redirectURIScheme
        )
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        DispatchQueue.main.async {
            webView.load(URLRequest(url: url))
        }
    }
    
    private func completion() {
        dismiss()
    }
}

class GSpotifySchemeHandler: NSObject, WKURLSchemeHandler {
    private let signInViewModel: SignInViewModel
    private let completion: () -> Void
    init(signInViewModel: SignInViewModel, completion: @escaping () -> Void) {
        self.signInViewModel = signInViewModel
        self.completion = completion
    }

    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        guard let url = webView.url,
                let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        
        if let code = components.queryItems?.first(where: { $0.name == "code" })?.value {
            Task {
                do {
                    try await signInViewModel.authenticate(
                        code: code,
                        redirectUri: URL(string: GlobalConstants.redirectURI)!
                    )
                    await MainActor.run(body: {
                        self.completion()
                    })
                } catch {
                    
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
    }
}
