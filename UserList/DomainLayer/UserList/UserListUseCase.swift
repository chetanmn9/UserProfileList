//
//  UserListUseCase.swift
//  UserList

import Foundation

protocol UserListUseCaseProtocol {
    func execute() async throws -> User
}

class UserListUseCase: UserListUseCaseProtocol {
    private let service: UserListServiceProtocol
    
    init(service: UserListServiceProtocol) {
        self.service = service
    }
    
    func execute() async throws -> User {
        let dtos = try await service.fetchUser()
        return UserListMapper.map(dto: dtos)
    }
}
