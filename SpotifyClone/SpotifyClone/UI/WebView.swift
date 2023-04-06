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
    
    var type: URLType
    var url: String?
    
    let signInViewModel: SignInViewModel
    
    let delegate = WebViewDelegate()
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.setURLSchemeHandler(GSpotifySchemeHandler(signInViewModel: signInViewModel), forURLScheme: "g-spotify")
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.navigationDelegate = delegate
        return webView
    
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlValue = url  {
            if let requestUrl = URL(string: urlValue) {
                webView.load(URLRequest(url: requestUrl))
            }
        }
    }
}

class GSpotifySchemeHandler: NSObject, WKURLSchemeHandler {
    let signInViewModel: SignInViewModel
    init(signInViewModel: SignInViewModel) {
        self.signInViewModel = signInViewModel
    }
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        guard let url = webView.url,
                let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        
        if let code = components.queryItems?.first(where: { $0.name == "code" })?.value {
            signInViewModel.authRequest(code: code, redirectUri: URL(string: "g-spotify://g-spotify-callback")!)
        }
    }
    
    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        print("stop urlSchemeTask", webView.url)
    }
}

class WebViewDelegate: NSObject, WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(webView.url)
    }
}
