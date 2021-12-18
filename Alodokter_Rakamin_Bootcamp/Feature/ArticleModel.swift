//
//  ArticleModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 08/12/21.
//

import Foundation

struct ArticlesModel: Codable {
    let code: Int
    let message: String
    let data: [Article]
    let currentPage, perPage, totalPage, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case code, message, data
        case currentPage = "current_page"
        case perPage = "per_page"
        case totalPage = "total_page"
        case totalCount = "total_count"
    }
}

// MARK: - Datum
struct Article: Codable {
    let id: Int
    let title: String
    let category: Category
    let image: String
    let headline: Bool?
    let content: String?
    let reviewer: String?
}

enum Category: String, Codable {
    case hidupSehat = "Hidup Sehat"
    case keluarga = "Keluarga"
    case kesehatan = "Kesehatan"
}
