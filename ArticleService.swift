//
//  ArticleService.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 17/12/21.
//
import Foundation

class ArticleService: BaseService{
    var param: String
    var value: Int
    
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
        return URL(string: "https://alogrup3.herokuapp.com/api/v1/articles?\(param)=\(value)")!
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    init(param: String,value: Int){
        
        self.param = param
        self.value = value
    }
    
}
