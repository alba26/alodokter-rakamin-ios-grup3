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
        loginView.forgotPassword.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        loginView.emailLoginTextField.addTarget(self, action: #selector(emailLoginValidation), for: .editingChanged)
        loginView.passwordLoginTextField.addTarget(self, action: #selector(passwordLoginValidation), for: .editingChanged)
        loginView.loginButton.isEnabled = false

        self.title = "Login"
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
            loginView.loginButton.isEnabled = false
        }
        
        loginVM.emailValidationMsg = { [self] msg in
            loginView.emailValidationMessage.text = msg
            loginView.emailValidationMessage.textColor = .red
        }
        
        loginVM.passwordValidationMsg = { [self] msg in
            loginView.passwordValidationMessage.text = msg
            loginView.passwordValidationMessage.textColor = .red
        }
        
        loginVM.enabledButton = {[self] isEnable in
            loginView.loginButton.isEnabled = isEnable ?? false
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
    
    @objc func emailLoginValidation(){
        loginVM.emailValidation(email: loginView.emailLoginTextField.text ?? "")
    }
    
    @objc func passwordLoginValidation(){
        loginVM.passwordValidation(password: loginView.passwordLoginTextField.text ?? "")
    }
    
    @objc func forgotPassword(){
        ArticleViewModel().getArticlesData()
    }
}

extension LoginViewController{
    
    private func failToLogin(title: String, message:String){
        utils.showAlertAction(title: title, message: message, uiview: self)
        loginView.passwordLoginTextField.text = ""
        loginView.isUserInteractionEnabled = true
    }
    
}


