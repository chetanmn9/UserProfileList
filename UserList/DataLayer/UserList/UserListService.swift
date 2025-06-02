//
//  UserListService.swift
//  UserList

import Foundation

protocol UserListServiceProtocol {
    func fetchUser() async throws -> UserResponseDTO
}

class UserListService: UserListServiceProtocol {
    func fetchUser() async throws -> UserResponseDTO {
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(UserResponseDTO.self, from: data)
    }
}
