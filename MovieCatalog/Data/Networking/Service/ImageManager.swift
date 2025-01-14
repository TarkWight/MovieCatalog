//
//  ImageManager.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//

import UIKit

@globalActor
actor ImageManagerActor: GlobalActor {
    static let shared = ImageManagerActor()
    
    // MARK: - Properties
    private let cache: URLCache
    private let session: URLSession

    private init() {
        let memoryCapacity = 50 * 1024 * 1024
        let diskCapacity = 50 * 1024 * 1024
        cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "imageCache")

        let configuration = URLSessionConfiguration.default
        configuration.urlCache = cache
        configuration.httpMaximumConnectionsPerHost = 5
        session = URLSession(configuration: configuration)
    }

    // MARK: - Public Methods

    func loadImage(from url: URL) async -> UIImage? {
        let request = URLRequest(url: url)

        if let cachedResponse = cache.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            return image
        }

        do {
            let (data, response) = try await session.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedResponse, for: request)
                return UIImage(data: data)
            }
        } catch {
            print("ImageManagerActor: Ошибка загрузки изображения по URL: \(url.absoluteString), ошибка: \(error)")
        }

        return nil
    }

    func clearCache() {
        cache.removeAllCachedResponses()
    }

    func removeImage(from url: URL) {
        let request = URLRequest(url: url)
        cache.removeCachedResponse(for: request)
    }
}
