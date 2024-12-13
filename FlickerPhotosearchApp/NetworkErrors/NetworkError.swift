//
//  NetworkError.swift
//  FlickerPhotosearchApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


enum NetworkError: Error {
    case invalidURL
    case decodingError(String)
    case invalidImageData
    case networkFailure(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .decodingError(let message):
            return "Failed to decode the response: \(message)"
        case .invalidImageData:
            return "The image data is invalid."
        case .networkFailure(let message):
            return "Network request failed: \(message)"
        }
    }
}
