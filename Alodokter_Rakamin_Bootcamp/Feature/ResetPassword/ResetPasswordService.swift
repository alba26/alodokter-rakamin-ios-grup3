//
//  ResetPasswordService.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 14/12/21.
//

import Foundation

class ResetPasswordService: BaseService {
    var oldPassword: String
    var newPassword: String
    var idUser: String
    
    func method() -> APIService.Method {
        return .put
    }
    
    func url() -> URL {
        return URL(string: "https://alogrup3.herokuapp.com/api/v1/users/\(idUser)/update_password")!
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func httpBody() -> [String : String] {
        return ["password":oldPassword, "new_password":newPassword]
    }
    
    func auth() -> String {
        return ""
    }
    
    init(oldPassword: String, newPassword: String, idUser: String) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.idUser = idUser
    }
    
}
