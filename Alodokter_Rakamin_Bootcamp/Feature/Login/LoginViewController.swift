//
//  LoginViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 08/12/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: LoginView!
    
    var email:String = ""
    var password:String = ""
    var loginDataToken:String?
    var userProfileData: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButton), for: .touchUpInside)
        
    }
    
    
   @objc func loginButton(){

       self.email = loginView.emailLoginTextField.text ?? "default"
       self.password = loginView.passwordLoginTextField.text ?? "default"
       if Utility().checkTextFieldIsEmpty(textfield: loginView.passwordLoginTextField){
           login()
       }else{
           print("KOSONG") //OUTPUT ERROR
       }

    }
    
    @objc func registerButton(){
        let registerStoryboard : UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
        let registerVC = registerStoryboard.instantiateViewController(withIdentifier: "RegisterViewController")
        self.present(registerVC, animated: true){
        }
    }

}

extension LoginViewController{

    func login(){
        let login = LoginService(email: self.email, password: self.password)
        
        APIService.APIRequest(model: LoginModel.self, req: login){ [self](result) in
            switch result {
            case .success(let result):
                guard let login = result as? LoginModel else{
                    return
                }
                if login.code == 201{
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(Session.loggedIn.rawValue, forKey: "session")
                        loginDataToken = login.data?.token
                        UserDefaults.standard.set(loginDataToken, forKey: "token")
                        self.dismiss(animated: true){
                            getUserData()
                        }
                    }
                } else if login.code == 401 {
                    DispatchQueue.main.async {
                        loginView.emailLoginTextField.text = login.message
                    }
                }
                
            case .failure(let err):
                print("Error",err) //OUTPUT ERROR
            }
        }
    }
    
    func getUserData(){
        let userProfile = UserProfileService(token: self.loginDataToken ?? "")
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
            case .failure(let error):
                print(error) //OUTPUT ERROR
            }
            
        }
    }
}
