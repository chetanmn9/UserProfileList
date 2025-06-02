//
//  CandidatesListViewModelTests.swift
//  UserList

import Foundation

import XCTest
@testable import UserList

class MockCandidatesListService: UserListServiceProtocol {
    var shouldFail = false

    func fetchUser() async throws -> UserResponseDTO {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        let user = [
            UserListDTO(id: 1,
                             email: "john.smith,@test.com",
                             firstName: "John",
                             lastName: "Smith",
                             avatar: "https://test.com/img/faces/3-image.jpg"),
            UserListDTO(id: 1,
                             email: "jane.smith@test.com",
                             firstName: "Jane", lastName: "Smith",
                             avatar: "https://test.com/img/faces/4-image.jpg")]
        return UserResponseDTO(page: 1,
                                    perPage: 1,
                                    total: 5,
                                    totalPages: 10,
                               user: user)
    }
}

final class UserListViewModelTests: XCTestCase {
    func testFetchUsersSuccess() async {
        let mockService = MockCandidatesListService()
        let useCase = UserListUseCase(service: mockService)
        let viewModel = UserListViewModel(userListUseCase: useCase)

        await viewModel.fetchUser()

        XCTAssertTrue(((viewModel.user?.user) != nil))
        XCTAssertEqual(viewModel.user?.user.first?.firstName, "John")
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchUsersFailure() async {
        let mockService = MockCandidatesListService()
        let useCase = UserListUseCase(service: mockService)
        let viewModel = UserListViewModel(userListUseCase: useCase)
        mockService.shouldFail = true

        await viewModel.fetchUser()

        XCTAssertTrue(((viewModel.user?.user) == nil))
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
