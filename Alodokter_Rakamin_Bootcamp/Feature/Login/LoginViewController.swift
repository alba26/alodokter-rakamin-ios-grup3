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
    var loginDataId:Int?
    var userProfileData: UserProfile?
    let utils = Utility()
    var loginVM = LoginViewModel()

    
    var test:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButton), for: .touchUpInside)
        loginView.forgotPassword.addTarget(self, action: #selector(lupa), for: .touchUpInside)
        hideSpinner()
        loginVM.msgSuccess = { [self] msg in
            loginView.emailLoginTextField.text = msg
            hideSpinner()
        }

    }
    
    
   @objc func loginButton(){

       self.email = loginView.emailLoginTextField.text ?? "default"
       self.password = loginView.passwordLoginTextField.text ?? "default"
       
       if utils.checkTextFieldIsEmpty(textfield: loginView.passwordLoginTextField){
           loginView.isUserInteractionEnabled = false
           showSpinner()
           login()
       }else{
           utils.showAlertAction(title: "Password Kosong", message: "Password tidak boleh kosong", uiview: self)
       }
    }
    
    @objc func registerButton(){
        let registerStoryboard : UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
        let registerVC = registerStoryboard.instantiateViewController(withIdentifier: "RegisterViewController")
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func lupa(){

        showSpinner()
        loginVM.login(email: loginView.emailLoginTextField.text ?? "default", password: loginView.passwordLoginTextField.text ?? "default")
        
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
                        
                        loginDataToken = login.data?.token
                        loginDataId = login.data?.id
                        
                        UserDefaults.standard.set(Session.loggedIn.rawValue, forKey: "session")
                        UserDefaults.standard.set(loginDataToken, forKey: "token")
                        
                        getUserData()
                        hideSpinner()
                        
                        loginView.isUserInteractionEnabled = true
                        let profileStoryboard : UIStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
                        let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController")
                        self.navigationController?.pushViewController(profileVC, animated: true)
                        self.navigationController?.viewControllers.remove(at: 1)
                    }
                } else if login.message == "No such user" {
                    failToLogin(title: "Login Gagal", message: "User tidak terdaftar")
                } else if login.message == "Incorrect password" {
                    failToLogin(title: "Login Gagal", message: "Password Salah")
                } else{
                    failToLogin(title: "Login Gagal", message: "Login gagal silahkan coba lagi")
                }
                
            case .failure(_):
                failToLogin(title: "Login Gagal", message: "Periksa jaringan anda")
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
            case .failure(let error):
                print(error) //OUTPUT ERROR
            }
            
        }
    }
    
    private func hideSpinner(){
        loginView.loginSpinner.isHidden = true
        loginView.loginSpinner.stopAnimating()
    }
    
    private func showSpinner(){
        loginView.loginSpinner.isHidden = false
        loginView.loginSpinner.startAnimating()
    }
    
    private func failToLogin(title: String, message:String){
        DispatchQueue.main.async { [self] in
            utils.showAlertAction(title: title, message: message, uiview: self)
            loginView.passwordLoginTextField.text = ""
            hideSpinner()
            loginView.isUserInteractionEnabled = true
        }
    }
    
}
