//
//  Article.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 08/12/21.
//

import Foundation

class ArticleService: BaseService{
    func method() -> APIService.Method {
        return .get
    }
    
    func url() -> URL {
        return URL(string: "http://localhost:3000/article")!
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func httpBody() -> [String : Any] {
        return [:]
    }
}
