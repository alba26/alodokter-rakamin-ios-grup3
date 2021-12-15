//
//  ArticleModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 08/12/21.
//

import Foundation

struct ArticleModel: Codable, Hashable{
    
    //samain nama var kayak di backend
    var listOfArticles: [Article]
    
}

struct Article: Codable, Hashable{
    //samain nama var kayak di backend
    var title: String
    var category: String
    var content: String
    var reviewer: String
    var image: String
}
