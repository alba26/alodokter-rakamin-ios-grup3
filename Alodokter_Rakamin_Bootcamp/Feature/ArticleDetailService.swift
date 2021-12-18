//
//  ArticleDetailService.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import Foundation

class ArticleDetailService: BaseService{
    var idArticle: String
    
    func httpBody() -> [String : String] {
        return [:]
    }
    
    func auth() -> String {
        return ""
    }
    
    func method() -> APIService.Method {
        return .get
    }
    
    func url() -> URL {
        return URL(string: "https://alogrup3.herokuapp.com/api/v1/articles/\(idArticle)")!
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    init(idArticle: String){
        self.idArticle = idArticle
    }
    
}
