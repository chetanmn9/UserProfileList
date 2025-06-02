//
//  UserList.swift
//  UserList

import Foundation

// MARK: - User
struct User {
    let page, perPage, total, totalPages: Int
    var user: [UserList]
}

// MARK: - UserList
struct UserList: Identifiable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}
