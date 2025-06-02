//
//  User.swift
//  UserList


// MARK: - CandidateResponseDTO
struct UserResponseDTO: Codable {
    let page, perPage, total, totalPages: Int
    let user: [UserListDTO]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case user = "data"
    }
}

// MARK: - CandidateListDTO
struct UserListDTO: Codable, Identifiable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case id //, email
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
