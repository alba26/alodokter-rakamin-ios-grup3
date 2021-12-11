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
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        
    }
    
    
   @objc func loginButton(){

       self.email = loginView.emailLoginTextField.text ?? "default"
       self.password = loginView.passwordLoginTextField.text ?? "default"
       if Utility().checkTextFieldIsEmpty(textfield: loginView.passwordLoginTextField){
           login()
       }else{
           print("KOSONG BRO")
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
                        let userProfileStoryboard : UIStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
                        let userProfileVC = userProfileStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController")
                        UserDefaults.standard.set(Session.loggedIn.rawValue, forKey: "session")
                        self.dismiss(animated: true){
                            print("GG")
                        }
                    }
                }else if login.code == 401 {
                    DispatchQueue.main.async {
                        loginView.emailLoginTextField.text = login.message
                    }
                }
            case .failure(let err):
                print("Error",err)
            }
        }
    }
}
