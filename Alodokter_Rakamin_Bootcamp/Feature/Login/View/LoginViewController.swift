//
//  LoginViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 08/12/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: LoginView!

    var userProfileData: UserProfile?
    let utils = Utility()
    var loginVM = LoginViewModel()
    let spinner = Utility().showSpinner()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButton), for: .touchUpInside)

        loginVM.msgSuccess = { [self] msg in
            let profileStoryboard : UIStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
            let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController")
            spinner.dismiss(animated: true, completion: {
                self.navigationController?.pushViewController(profileVC, animated: true)
                self.navigationController?.viewControllers.remove(at: 1)
            })

        }
        loginVM.msgFail = { [self] msg in
            spinner.dismiss(animated: true, completion: {
                failToLogin(title: "Login Gagal", message: msg ?? "")
            })

        }

    }
    
    @objc func registerButton(){
        let registerStoryboard : UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
        let registerVC = registerStoryboard.instantiateViewController(withIdentifier: "RegisterViewController")
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func loginButton(){
        self.present(spinner, animated: true, completion: nil)
        loginVM.login(email: loginView.emailLoginTextField.text ?? "default", password: loginView.passwordLoginTextField.text ?? "default")
        
    }
}

extension LoginViewController{
    
    private func failToLogin(title: String, message:String){
        utils.showAlertAction(title: title, message: message, uiview: self)
        loginView.passwordLoginTextField.text = ""
        loginView.isUserInteractionEnabled = true
    }
    
}







//@objc func loginButton(){
//
//   self.email = loginView.emailLoginTextField.text ?? "default"
//   self.password = loginView.passwordLoginTextField.text ?? "default"
//   if utils.checkTextFieldIsEmpty(textfield: loginView.passwordLoginTextField){
//       loginView.isUserInteractionEnabled = false
//       showSpinner()
//       login()
//   }else{
//       utils.showAlertAction(title: "Password Kosong", message: "Password tidak boleh kosong", uiview: self)
//   }
//}


//func login(){
//    let login = LoginService(email: self.email, password: self.password)
//    APIService.APIRequest(model: LoginModel.self, req: login){ [self](result) in
//        switch result {
//        case .success(let result):
//            guard let login = result as? LoginModel else{
//                return
//            }
//            if login.code == 201{
//
//                DispatchQueue.main.async {
//
//                    loginDataToken = login.data?.token
//                    loginDataId = login.data?.id
//
//                    UserDefaults.standard.set(Session.loggedIn.rawValue, forKey: "session")
//                    UserDefaults.standard.set(loginDataToken, forKey: "token")
//
//                    getUserData()
//                    hideSpinner()
//
//                    loginView.isUserInteractionEnabled = true
//                    let profileStoryboard : UIStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
//                    let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController")
//                    self.navigationController?.pushViewController(profileVC, animated: true)
//                    self.navigationController?.viewControllers.remove(at: 1)
//                }
//            } else if login.message == "No such user" {
//                failToLogin(title: "Login Gagal", message: "User tidak terdaftar")
//            } else if login.message == "Incorrect password" {
//                failToLogin(title: "Login Gagal", message: "Password Salah")
//            } else{
//                failToLogin(title: "Login Gagal", message: "Login gagal silahkan coba lagi")
//            }
//
//        case .failure(_):
//            failToLogin(title: "Login Gagal", message: "Periksa jaringan anda")
//        }
//    }
//}
//
//func getUserData(){
//    let userProfile = UserProfileService(token: self.loginDataToken ?? "", id: self.loginDataId ?? 1)
//    APIService.APIRequest(model: UserData.self, req: userProfile){ [self](result) in
//        switch result {
//        case .success(let user):
//            guard let myData = user as? UserData else{
//                return
//            }
//            if myData.code == 200{
//                do{
//                    userProfileData = myData.data
//                    let encoder = JSONEncoder()
//                    let data = try encoder.encode(userProfileData)
//                    UserDefaults.standard.set(data, forKey: "userdata")
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeNameLabel"), object: nil)
//                }catch{
//                    print(error)
//                }
//            }
//        case .failure(let error):
//            print(error) //OUTPUT ERROR
//        }
//
//    }
//}
