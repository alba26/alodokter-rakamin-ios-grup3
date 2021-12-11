//
//  UserLogin.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 08/12/21.
//

import Foundation

class UserLoginService: BaseService{

    func method() -> APIService.Method {
        return .post
    }
    
    func url() -> URL {
        return URL(string: "http://localhost:3000/content/:param1")!
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func httpBody() -> [String : Any] {
        return ["pass":"alba","username":"alba26"]
    }
    

}
