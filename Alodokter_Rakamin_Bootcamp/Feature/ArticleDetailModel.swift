//
//  ArticlesDetailModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import Foundation

struct ArticleDetailsModel: Codable {
    let code: Int
    let message: String
    let data: Article
    let currentPage, perPage, totalPage, totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case code, message, data
        case currentPage = "current_page"
        case perPage = "per_page"
        case totalPage = "total_page"
        case totalCount = "total_count"
    }
}
