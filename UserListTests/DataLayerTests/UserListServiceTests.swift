//
//  UserListServiceTests.swift
//  UserList


import Foundation
import XCTest
@testable import UserList

final class UserDecoderTests: XCTestCase {

    func testUserDecoding_Success() throws {
        let json = """
        {
                "page": 1,
                "per_page": 6,
                "total": 12,
                "total_pages": 2,
                "data": [
                  {
                    "id": 1,
                    "email": "george.bluth@reqres.in",
                    "first_name": "George",
                    "last_name": "Bluth",
                    "avatar": "https://reqres.in/img/faces/1-image.jpg"
                  },
                  {
                    "id": 6,
                    "email": "tracey.ramos@reqres.in",
                    "first_name": "Tracey",
                    "last_name": "Ramos",
                    "avatar": "https://reqres.in/img/faces/6-image.jpg"
                  }
                ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let user = try decoder.decode(UserResponseDTO.self, from: json)
        
        XCTAssertEqual(user.page, 1)
        XCTAssertEqual(user.perPage, 6)
        XCTAssertEqual(user.total, 12)
        XCTAssertEqual(user.totalPages, 2)
        XCTAssertEqual(user.user.count, 2)
        XCTAssertEqual(user.user.first?.id, 1)
        XCTAssertEqual(user.user.first?.firstName, "George")
        XCTAssertEqual(user.user.first?.lastName, "Bluth")
        XCTAssertEqual(user.user.first?.email, "george.bluth@reqres.in")
        XCTAssertEqual(user.user.first?.avatar, "https://reqres.in/img/faces/1-image.jpg")
    }

    func testUserDecoding_MissingField() {
        let json = """
        {
            "page": 1,
            "per_page": 6,
            "total": 12,
            "total_pages": 2,
            "data": [
                {
                    "id": 1,
                    "email": "george.bluth@reqres.in",
                    "last_name": "Bluth",
                    "avatar": "https://reqres.in/img/faces/1-image.jpg"
                },
                {
                    "id": 6,
                    "email": "tracey.ramos@reqres.in",
                    "first_name": "Tracey",
                    "last_name": "Ramos",
                    "avatar": "https://reqres.in/img/faces/6-image.jpg"
                }
            ]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()

        XCTAssertThrowsError(try decoder.decode(UserResponseDTO.self, from: json)) { error in
            print("Caught expected error: \(error)")
        }
    }

    func testUserDecoding_InvalidType() {
        let json = """
                {
                    "page": 1,
                    "per_page": 6,
                    "total": 12,
                    "total_pages": 2,
                    "data": [
                        {
                            "id": "1",
                            "email": "george.bluth@reqres.in",
                            "last_name": "Bluth",
                            "avatar": "https://reqres.in/img/faces/1-image.jpg"
                        },
                        {
                            "id": 6,
                            "email": "tracey.ramos@reqres.in",
                            "first_name": "Tracey",
                            "last_name": "Ramos",
                            "avatar": "https://reqres.in/img/faces/6-image.jpg"
                        }
                    ]
                }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        XCTAssertThrowsError(try decoder.decode(UserResponseDTO.self, from: json)) { error in
            print("Caught expected error: \(error)")
        }
    }
}
