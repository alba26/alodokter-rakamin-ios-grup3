//
//  LoginModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 08/12/21.
//

import Foundation

struct LoginModel: Codable {
    let code: Int
    let message: String
    let data: DataLogin?
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
struct DataLogin: Codable {
    let id: Int
    let email, token: String
}
