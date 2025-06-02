//
//  UserListViewModel.swift
//  UserList

import Foundation

class UserListViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let userListUseCase: UserListUseCaseProtocol

    init(userListUseCase: UserListUseCaseProtocol) {
        self.userListUseCase = userListUseCase
    }

    @MainActor
    func fetchUser() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await userListUseCase.execute()
            user = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
