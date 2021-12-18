//
//  RegisterService.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 11/12/21.
//

import Foundation

class RegisterService:BaseService{
    
    var email, fullname, phone: String
    var password : String
    
    func method() -> APIService.Method {
        return .post
    }
    
    func url() -> URL {
        return URL(string: "https://alogrup3.herokuapp.com/api/v1/users/register")!
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func httpBody() -> [String : String] {
        return ["email":email,"fullname":fullname,"phone":phone,"password":password]
    }
    
    func auth() -> String {
        return ""
    }
    
    init(email:String, fullname:String, phone:String,  password: String) {
        self.email = email
        self.fullname = fullname
        self.phone = phone
        self.password = password
    }

}
