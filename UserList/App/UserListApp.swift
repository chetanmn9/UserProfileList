//
//  UserListApp.swift
//  UserList


import SwiftUI

@main
struct UserListApp: App {
    var body: some Scene {
        WindowGroup {
            let service = UserListService()
            let useCase = UserListUseCase(service: service)
            let viewModel = UserListViewModel(userListUseCase: useCase)
            let imageService = ImageService()
            let imageFetcherUseCase = ImageFetcherUseCase(service: imageService)
            UserListView(viewModel: viewModel, useCase: imageFetcherUseCase)
        }
    }
}
