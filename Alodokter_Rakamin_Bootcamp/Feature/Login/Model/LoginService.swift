//
//  LoginService.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 11/12/21.
//

import Foundation

class LoginService: BaseService{
    var email:String
    var password:String
    func method() -> APIService.Method {
        return .post
    }
    
    func url() -> URL {
        return URL(string: "https://alogrup3.herokuapp.com/api/v1/users/login")!
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func httpBody() -> [String : String] {
        return ["email":email,"password":password]
    }
    
    func auth() -> String {
        return ""
    }
    
    init(email:String, password:String) {
        self.email = email
        self.password = password
    }
    
    
}
