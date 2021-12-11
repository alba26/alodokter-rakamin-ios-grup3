//
//  RegisterService.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 11/12/21.
//

import Foundation

class RegisterService:BaseService{
    
    var email, firstname, lastname, birthdate: String
    var gender, phone, identity, address: String
    var city: String
    
    func method() -> APIService.Method {
        return .post
    }
    
    func url() -> URL {
        return URL(string: "https://hidden-cliffs-45052.herokuapp.com/api/v1/users/register")!
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func httpBody() -> [String : String] {
        return ["email":email,"firstname":firstname,"lastname":lastname,"birthdate":birthdate,"gender":gender,"phone":phone,"identity":identity,"addres":address,"city":city]
    }
    
    func auth() -> String {
        return ""
    }
    
    init(email:String, firstname:String, lastname:String, birthdate:String, gender:String, phone:String, identity:String, addres:String, city:String) {
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.birthdate = birthdate
        self.gender = gender
        self.phone = phone
        self.identity = identity
        self.address = addres
        self.city = city
    }

}
