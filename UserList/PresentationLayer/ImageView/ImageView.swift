//
//  ImageView.swift
//  UserList

import SwiftUI

struct ImageView: View {
    
    @StateObject var viewModel: ImageViewModel
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            } else {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
        }
        .onAppear {
            viewModel.loadImage()
        }
    }
}
