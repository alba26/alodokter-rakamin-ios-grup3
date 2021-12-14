//
//  RegisterService.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 11/12/21.
//

import Foundation

class RegisterService:BaseService{
    
    var email, fullname, birthdate: String
    var gender, phone, identity, address: String
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
        return ["email":email,"fullname":fullname,"birthdate":birthdate,"gender":gender,"phone":phone,"identity":identity,"addres":address,"password":password]
    }
    
    func auth() -> String {
        return ""
    }
    
    init(email:String, fullname:String, birthdate:String, gender:String, phone:String, identity:String, address:String, password: String) {
        self.email = email
        self.fullname = fullname
        self.birthdate = birthdate
        self.gender = gender
        self.phone = phone
        self.identity = identity
        self.address = address
        self.password = password
    }

}
