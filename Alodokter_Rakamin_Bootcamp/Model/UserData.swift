//
//  UserData.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 11/12/21.
//

import Foundation


struct UserData: Codable {
    let code: Int
    let message: String
    let data: UserProfile
    let currentPage, perPage, totalPage, totalCount: Bool?
    enum CodingKeys: String, CodingKey {
        case code, message, data
        case currentPage = "current_page"
        case perPage = "per_page"
        case totalPage = "total_page"
        case totalCount = "total_count"
    }
}

// MARK: - DataClass
struct UserProfile: Codable {
    let id: Int
    let email, firstname, lastname, birthdate: String
    let gender, phone, identity, address: String
    let city: String
}
