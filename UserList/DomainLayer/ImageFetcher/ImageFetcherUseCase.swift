//
//  ImageFetchUseCase.swift
//  UserList

import Foundation
import UIKit

protocol ImageFetcherUseCaseProtocol {
    func execute(imageUrls: [URL]) async throws -> [UIImage]
    func execute(imageUrl: URL) async throws -> UIImage
}

class ImageFetcherUseCase {
    
        private let service: ImageServiceProtocol
    
        init(service: ImageServiceProtocol) {
            self.service = service
        }
    
        func execute(imageUrls: [URL]) async throws -> [UIImage] {
            return try await withThrowingTaskGroup(of: UIImage.self) { group in
                for url in imageUrls {
                    group.addTask {
                        try await self.service.downloadImage(from: url)
                    }
                }
    
                var images: [UIImage] = []
                for try await image in group {
                    images.append(image)
                }
                return images
            }
        }
    
        func execute(imageUrl: URL) async throws -> UIImage {
            let image = try await service.downloadImage(from: imageUrl)
            return image
        }
    
    
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                return nil
            }
        return image
        
    }
    
    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
        
    }

}

