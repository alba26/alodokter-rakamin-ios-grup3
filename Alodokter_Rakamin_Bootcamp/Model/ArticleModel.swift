//
//  ArticleModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 08/12/21.
//

import Foundation

struct ArticleModel:Codable, Hashable{
    var title: String
    var category: String
    var content: String
}
