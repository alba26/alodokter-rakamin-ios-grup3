//
//  LoginViewModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 14/12/21.
//

import Foundation


class LoginViewModel{
    
    var loginDataToken:String?
    var loginDataId:Int?
    var loginMsg:String?
    var userProfileData: UserProfile?
    
    var loginData:LoginModel?
    var msgSuccess: ((String?) -> Void)?
    var msgFail: ((String?) -> Void)?
    
    
    func login(email: String, password:String) {
        let login = LoginService(email: email, password: password)
        APIService.APIRequest(model: LoginModel.self, req: login){ [self](result) in
            switch result {
            case .success(let result):
                guard let login = result as? LoginModel else{
                    return
                }
                if login.code == 201{
                    DispatchQueue.main.async {
                        loginDataToken = login.data?.token
                        loginDataId = login.data?.id
                        UserDefaults.standard.set(Session.loggedIn.rawValue, forKey: "session")
                        UserDefaults.standard.set(loginDataToken, forKey: "token")
                        loginMsg = login.message
                        getUserData()
                        msgSuccess?(loginMsg)
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        loginMsg = login.message
                        msgFail?(loginMsg)
                    }

                }
                
            case .failure(_):
                loginMsg = "Server Error"
                msgFail?(loginMsg)
            }
        }
    }
    
    func getUserData(){
        let userProfile = UserProfileService(token: self.loginDataToken ?? "", id: self.loginDataId ?? 1)
        APIService.APIRequest(model: UserData.self, req: userProfile){ [self](result) in
            switch result {
            case .success(let user):
                guard let myData = user as? UserData else{
                    return
                }
                if myData.code == 200{
                    do{
                        userProfileData = myData.data
                        let encoder = JSONEncoder()
                        let data = try encoder.encode(userProfileData)
                        UserDefaults.standard.set(data, forKey: "userdata")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeNameLabel"), object: nil)
                    }catch{
                        print(error)
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    loginMsg = "Server Error"
                    msgFail?(loginMsg)
                }
            }
            
        }
    }
}
