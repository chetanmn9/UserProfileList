//
//  UserListMapper.swift
//  UserList

import Foundation

final class UserListMapper {
    
    static func map(userDTO: UserListDTO) -> UserList {
        return UserList(id: userDTO.id,
                             email: userDTO.email,
                             firstName: userDTO.firstName,
                             lastName: userDTO.lastName,
                             avatar: userDTO.avatar ?? "No Avatar")
    }
    
    static func map(dto: UserResponseDTO) -> User {
        let userList = dto.user.map { map(userDTO: $0) }
        return User(
            page: dto.page,
            perPage: dto.perPage,
            total: dto.total,
            totalPages: dto.totalPages,
            user: userList)
    }
}
