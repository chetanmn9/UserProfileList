//
//  ImageService.swift
//  UserList

import Foundation
import UIKit

protocol ImageServiceProtocol {
    func downloadImage(from url: URL) async throws -> UIImage
}

class ImageService: ImageServiceProtocol {
    func downloadImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        return image
    }
}
