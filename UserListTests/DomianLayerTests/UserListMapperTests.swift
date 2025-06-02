//
//  UserListMapperTests.swift
//  UserList


import Foundation
import XCTest
@testable import UserList

final class UserMapperTests: XCTestCase {

    func test_map_singleUserDTO_toDomainModel_withUserDTO() {
        let UserListDTO = [
            UserListDTO(id: 1,
                         email: "john.smith,@test.com",
                         firstName: "John",
                         lastName: "Smith",
                         avatar: "https://test.com/img/faces/3-image.jpg"),
            UserListDTO(id: 1,
                              email: "jane.smith@test.com",
                              firstName: "Jane", lastName: "Smith",
                              avatar: "https://test.com/img/faces/4-image.jpg")]

        let dto = UserResponseDTO(page: 1,
                                       perPage: 1,
                                       total: 5,
                                       totalPages: 10,
                                  user: UserListDTO)

        let user = UserListMapper.map(dto: dto)

        XCTAssertEqual(user.page, 1)
        XCTAssertEqual(user.perPage, 1)
        XCTAssertEqual(user.total, 5)
        XCTAssertEqual(user.totalPages, 10)
        XCTAssertEqual(user.user.count, 2)
        XCTAssertEqual(user.user.first?.id, 1)
        XCTAssertEqual(user.user.first?.firstName, "John")
        XCTAssertEqual(user.user.first?.lastName, "Smith")
        XCTAssertEqual(user.user.first?.email, "john.smith,@test.com")
        XCTAssertEqual(user.user.first?.avatar, "https://test.com/img/faces/3-image.jpg")
    }
}

