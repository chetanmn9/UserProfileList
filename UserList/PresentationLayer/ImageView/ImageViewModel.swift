//
//  ImageViewModel.swift
//  UserList

import Foundation
import UIKit

class ImageViewModel: ObservableObject {
    
        @Published var image: UIImage? = nil
    
        private let url: URL
        private let useCase: ImageFetcherUseCase
    
        init(url: URL,
             useCase: ImageFetcherUseCase) {
        self.url = url
        self.useCase = useCase
    }
    
        func loadImage() {
            Task {
                if image == nil {
                    do {
                        let imageDownloaded = try? await useCase.execute(imageUrl: url)
                        await MainActor.run {
                            self.image = imageDownloaded
                        }
                    } catch {
                        print("Error loading image: \(error)")
                    }
                }
            }
        }
}
