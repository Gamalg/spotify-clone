//
//  ImageLoadClient.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 26.04.2023.
//

import Foundation
import UIKit

enum ImageLoadClientError: Error {
    case noImage
}

class ImageLoadClient {
    private let urlCache: URLCache

    init() {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cachePath = cacheDirectory.appendingPathComponent("ImageCache")
        urlCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, directory: cachePath)
    }

    func getImage(for url: URL) async throws -> UIImage {
        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url)),
           let image = UIImage(data: cachedResponse.data) {
            return image
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        guard let image = UIImage(data: data) else {
            throw ImageLoadClientError.noImage
        }
        
        return image
    }
}
