//
//  ChangeDataService.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 18/12/21.
//

import Foundation


class ChangeDataService:BaseService{
    let email,fullname,birthdate,gender,phone,identity,address:String
    let token: String
    let id:Int
    
    func method() -> APIService.Method {
        return .put
    }
    
    func url() -> URL {
        return URL(string: "https://alogrup3.herokuapp.com/api/v1/users/\(id)/update_personal")!
    }
    
    func timeout() -> TimeInterval {
        return 10
    }
    
    func httpBody() -> [String : String] {
        return ["email":email,"fullname":fullname,"birthdate":birthdate,"gender":gender,"phone":phone,"identity":identity,"address":address]
    }
    
    func auth() -> String {
        return token
    }
    init(token:String,id:Int,gender:String,birthdate:String,address:String,identity:String,email:String,phone:String,fullname:String){
        self.token = "Bearer "+token
        self.id = id
        self.gender = gender
        self.birthdate = birthdate
        self.address = address
        self.identity = identity
        self.email = email
        self.phone = phone
        self.fullname = fullname

    }
    
}
