//
//  FlickrSearchViewModel.swift
//  FlickerPhotosearchApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import Foundation

class FlickrViewModel {
    private let networkManager = NetworkManager.shared
    private let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="

    var photos: [FlickrImage] = [] {
        didSet {
            onDataFetched?()
        }
    }

    var onDataFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    func searchImages(for query: String) {
        let url = baseURL + query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        Task {
            do {
                let response: FlickrResponse = try await networkManager.fetchData(url: url)
                self.photos = response.items
                
                // Debug: Log fetched data
                print("Fetched Photos: \(self.photos.count)")
                self.photos.forEach { photo in
                    print("Title: \(photo.title)")
                    print("Image URL: \(photo.link)")
                }
            } catch {
                print("Error fetching images: \(error)")
                onError?("Failed to fetch data. Please try again.")
            }
        }
    }
}

