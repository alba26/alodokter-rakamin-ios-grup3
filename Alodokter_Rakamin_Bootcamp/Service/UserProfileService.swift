//
//  UserProfileService.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 11/12/21.
//

import Foundation

class UserProfileService: BaseService{
    var token:String
    var id:Int
    
    func method() -> APIService.Method {
        return .get
    }
    
    func url() -> URL {
        return URL(string: "https://alogrup3.herokuapp.com/api/v1/users/\(id)")!
    }
    
    func timeout() -> TimeInterval {
        return 10
    }
    
    func httpBody() -> [String : String] {
        [:]
    }
    
    func auth() -> String {
        return token
    }
    
    init(token:String,id:Int){
        self.token = "Bearer "+token
        self.id = id
    }
    
}
