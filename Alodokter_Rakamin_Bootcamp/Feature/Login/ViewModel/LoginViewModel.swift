//
//  LoginViewModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 14/12/21.
//

import Foundation


class LoginViewModel{
    
    
    var userProfileData: UserProfile?
    var loginData:LoginModel?
    var msgSuccess: ((String?) -> Void)?
    var msgFail: ((String?) -> Void)?
    var emailValidationMsg: ((String?) -> Void)?
    var passwordValidationMsg: ((String?) -> Void)?
    var enabledButton: ((Bool?) -> Void)?
    var isEmailValid = false
    var isPasswordValid = false
    
    
    func emailValidation(email:String){
        isEmailValid = false
        checkEmailAndPassword()
        emailValidationMsg?("Email tidak valid")
        guard !Utility().isValidEmail(text: email) else{
            emailValidationMsg?("")
            isEmailValid = true
            checkEmailAndPassword()
            return
        }
        guard !email.isEmpty else {
            emailValidationMsg?("Email tidak boleh kosong")
            return
        }
        
    }
    func passwordValidation(password:String){
        isPasswordValid = false
        checkEmailAndPassword()
        passwordValidationMsg?("Password kurang dari 6 digit")
        guard password.count < 6 else {
            passwordValidationMsg?("")
            isPasswordValid = true
            checkEmailAndPassword()
            return
        }
        guard !password.isEmpty else {
            passwordValidationMsg?("Password tidak boleh kosong")
            return
        }
  
    }
    
    
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
//                        loginDataToken = login.data?.token
//                        loginDataId = login.data?.id
                        UserDefaults.standard.set(Session.loggedIn.rawValue, forKey: "session")
                        UserDefaults.standard.set(login.data?.token, forKey: "token")
//                        loginMsg = login.message
                        getUserData(token: login.data?.token ?? "", id: login.data?.id ?? 1)
                        msgSuccess?(login.message)
                        
                    }
                } else {
                    DispatchQueue.main.async {
//                        loginMsg = login.message
                        msgFail?(login.message)
                    }

                }
                
            case .failure(_):
//                loginMsg = "Server Error"
                msgFail?("Server Error")
            }
        }
    }
    
    func getUserData(token:String, id:Int){
        let userProfile = UserProfileService(token: token, id: id)
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
//                    loginMsg = "Server Error"
                    msgFail?("Server Error")
                }
            }
            
        }
    }
    
    private func checkEmailAndPassword(){
        if isEmailValid && isPasswordValid{
            enabledButton?(true)
        }else{
            enabledButton?(false)
        }
    }
}
