//
//  NetworkManager.swift
//  FlickerPhotosearchApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


//import UIKit
//import Foundation
//
//final class NetworkManager {
//    static let shared = NetworkManager()
//    private let session: URLSession
//    private let cache = NSCache<NSString, UIImage>()
//
//    private init() {
//        let config = URLSessionConfiguration.default
//        self.session = URLSession(configuration: config)
//    }
//
//    func fetchData<T: Decodable>(from urlString: String, decodingType: T.Type) async throws -> T {
//        guard let url = URL(string: urlString) else {
//            throw URLError(.badURL)
//        }
//
//        let (data, response) = try await session.data(from: url)
//
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw URLError(.badServerResponse)
//        }
//
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return try decoder.decode(T.self, from: data)
//    }
//
//    func fetchImage(from urlString: String) async throws -> UIImage {
//        if let cachedImage = cache.object(forKey: NSString(string: urlString)) {
//            return cachedImage
//        }
//
//        guard let url = URL(string: urlString) else {
//            throw URLError(.badURL)
//        }
//
//        let (data, response) = try await session.data(from: url)
//
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw URLError(.badServerResponse)
//        }
//
//        guard let image = UIImage(data: data) else {
//            throw URLError(.cannotDecodeContentData)
//        }
//
//        cache.setObject(image, forKey: NSString(string: urlString))
//        return image
//    }
//}

import Foundation
import UIKit



// MARK: - SubscribeNetwork Class
class NetworkManager {
    static let shared = NetworkManager()
    private let session: URLSession
    private var cache = NSCache<NSString, UIImage>()

    private init() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }

    // MARK: - Fetch Data
    func fetchData<T: Codable>(url: String) async throws -> T {
        guard let serverURL = URL(string: url) else {
            throw NetworkError.invalidURL
        }

            let (data, _) = try await session.data(from: serverURL)

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch let decodingError as DecodingError {
                throw NetworkError.decodingError(decodingError.localizedDescription)
            }
    }

    // MARK: - Fetch Image
    func fetchImage(url: String) async throws -> UIImage {
        if let cachedImage = cache.object(forKey: url as NSString) {
            return cachedImage
        }

        guard let serverURL = URL(string: url) else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, _) = try await session.data(from: serverURL)
            

            guard let image = UIImage(data: data) else {
                throw NetworkError.invalidImageData
            }

            cache.setObject(image, forKey: url as NSString)
            return image
        } catch {
            throw NetworkError.networkFailure(error.localizedDescription)
        }
    }
}
