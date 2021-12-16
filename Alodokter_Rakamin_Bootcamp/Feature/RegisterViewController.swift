//
//  RegisterViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 08/12/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerView: RegisterView!
    
    let utils = Utility()
    let registerVM = RegisterViewModel()
    var spinner = Utility().showSpinner()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        registerView.nameRegisterTextField.addTarget(self, action: #selector(nameRegisterValidation), for: .editingChanged)
        registerView.emailRegisterTextField.addTarget(self, action: #selector(emailRegisterValidation), for: .editingChanged)
        registerView.phoneRegisterTextField.addTarget(self, action: #selector(phoneRegisterValidation), for: .editingChanged)
        registerView.passwordRegisterTextField.addTarget(self, action: #selector(passwordRegisterValidation), for: .editingChanged)
        registerView.passwordConfirmRegisterTextField.addTarget(self, action: #selector(passwordConfirmRegisterValidation), for: .editingChanged)
        registerView.registerButton.isEnabled = false
        self.title = "Registrasi"
        
        registerVM.registerSuccess = { [self] msg in
            spinner.dismiss(animated: true, completion: {
                utils.showAlertAction(title: "Pendaftaran Berhasil", message: msg ?? "Silahkan Login.", uiview: self, action: true)
                self.navigationController?.viewControllers.removeLast()
            })
            registerView.isUserInteractionEnabled = true
        }
        
        registerVM.registerFailed = { [self] msg in
            spinner.dismiss(animated: true, completion: {
                utils.showAlertAction(title: "Pendaftaran Gagal", message: msg ?? "", uiview: self)
            })
            registerView.isUserInteractionEnabled = true
        }
        
        registerVM.nameValidationMsg = { [self] msg in
            registerView.namaValidationLabel.text = msg
            registerView.namaValidationLabel.textColor = .red
        }
        
        registerVM.emailValidationMsg = {[self] msg in
            registerView.emailValidationLabel.text = msg
            registerView.emailValidationLabel.textColor = .red
        }
        
        registerVM.phoneValidationMsg = {[self] msg in
            registerView.hpValidationLabel.text = msg
            registerView.hpValidationLabel.textColor = .red
        }
        
        registerVM.passwordValidationMsg = { [self] msg in
            registerView.passwordValidationLabel.text = msg
            registerView.passwordValidationLabel.textColor = .red
        }
        
        registerVM.confirmPasswordValidationMsg = {[self] msg in
            registerView.passwordConfirmValidationLabel.text = msg
            registerView.passwordConfirmValidationLabel.textColor = .red
        }
        
        registerVM.enableRegister = {[self] enabledRegister in
            registerView.registerButton.isEnabled = enabledRegister ?? false
        }
    }
    @objc func register(){
        registerVM.register(email:  registerView.emailRegisterTextField.text ?? "", fullname: registerView.nameRegisterTextField.text ?? "", password: registerView.passwordRegisterTextField.text ?? "", phone: registerView.phoneRegisterTextField.text ?? "")
        self.present(spinner, animated: true, completion: nil)
        
    }
    
    @objc func nameRegisterValidation(){
        registerVM.nameValidation(name: registerView.nameRegisterTextField.text ?? "")
    }
    
    @objc func emailRegisterValidation(){
        registerVM.emailValidation(email: registerView.emailRegisterTextField.text ?? "")
    }
    
    @objc func phoneRegisterValidation(){
        registerVM.phoneValidation(phone: registerView.phoneRegisterTextField.text ?? "")
    }
    
    @objc func passwordRegisterValidation(){
        registerVM.passwordValidation(password: registerView.passwordRegisterTextField.text ?? "")
    }
    
    @objc func passwordConfirmRegisterValidation(){
        registerVM.confirmPasswordValidation(password: registerView.passwordRegisterTextField.text ?? "", confirmPassword: registerView.passwordConfirmRegisterTextField.text ?? "")
    }
}
