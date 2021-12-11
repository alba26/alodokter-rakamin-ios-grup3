//
//  Session.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 11/12/21.
//

import Foundation

enum Session:String{
    case unregistered = "unregistered"
    case loggedIn = "loggedIn"
    case sessionExpired = "sessionExpired"
}


extension UserDefaults{
    func checkSession() -> String{
        guard let state = UserDefaults.standard.value(forKey: "session") as? String else{
            return ""
        }
        return state
    }
    
    func checkIsUserLogin() -> Bool{
        let session = UserDefaults.standard.value(forKey: "session") as? String
        if session == Session.loggedIn.rawValue{
            return true
        } else {
            return false
        }
    }
    
}

