//
//  RegisterViewModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 15/12/21.
//

import Foundation

class RegisterViewModel{
    
    var registerSuccess: ((String?) -> Void)?
    var registerFailed: ((String?) -> Void)?
    var nameValidationMsg: ((String?) -> Void)?
    var emailValidationMsg: ((String?) -> Void)?
    var phoneValidationMsg: ((String?) -> Void)?
    var passwordValidationMsg: ((String?) -> Void)?
    var confirmPasswordValidationMsg: ((String?) -> Void)?
    var enableRegister: ((Bool?) -> Void)?
    
    var isNameValid = false
    var isEmailValid = false
    var isPhoneValid = false
    var isPasswordValid = false
    var isConfirmPasswordValid = false
    
    func nameValidation(name: String){
        isNameValid = false
        checkAllToRegister()
        guard name.isEmpty else {
            isNameValid = true
            checkAllToRegister()
            nameValidationMsg?("")
            return
        }
        
        nameValidationMsg?("Nama tidak boleh kosong")
    }
    
    func emailValidation(email: String){
        isEmailValid = false
        checkAllToRegister()
        emailValidationMsg?("Email tidak valid")
        guard !Utility().isValidEmail(text: email) else {
            isEmailValid = true
            checkAllToRegister()
            emailValidationMsg?("")
            return
        }
        guard !email.isEmpty else {
            emailValidationMsg?("Email tidak boleh kosong")
            return
        }
    }
    
    func phoneValidation(phone: String){
        isPhoneValid = false
        checkAllToRegister()
        guard !Utility().stringHasCharacter(phone) else {
            phoneValidationMsg?("Nomor tidak boleh mengandung karakter")
            return
        }
        guard phone.count >= 10 && phone.count <= 12 else {
            phoneValidationMsg?("Nomor HP harus berjumlah 10/12")
            return
        }
        isPhoneValid = true
        checkAllToRegister()
        phoneValidationMsg?("")
    }
    
    func passwordValidation(password: String){
        isPasswordValid = false
        checkAllToRegister()
        passwordValidationMsg?("Password kurang dari 6 digit")
        guard password.count < 6 else {
            passwordValidationMsg?("")
            isPasswordValid = true
            checkAllToRegister()
            return
        }
        guard !password.isEmpty else {
            passwordValidationMsg?("Password tidak boleh kosong")
            return
        }
    }
    
    func confirmPasswordValidation(password:String, confirmPassword: String){
        isConfirmPasswordValid = false
        checkAllToRegister()
        confirmPasswordValidationMsg?("Password tidak cocok")
        guard password != confirmPassword else {
            isConfirmPasswordValid = true
            checkAllToRegister()
            confirmPasswordValidationMsg?("")
            return
        }
        
    }
    
    func register(email: String, fullname: String, password:String, phone:String){
        let registerService = RegisterService(email: email , fullname: fullname, phone: phone, password: password)
        APIService.APIRequest(model: UserData.self, req: registerService){ [self](result) in
            switch result {
            case .success(let user):
                guard let register = user as? UserData else{
                    return
                }
                if register.code == 201{
                    DispatchQueue.main.async {
                        registerSuccess?("Sukses melakukan registrasi")
                    }
                }else{
                    DispatchQueue.main.async {
                        registerFailed?(register.message)
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    registerFailed?("Gagal untuk melakukan pendaftaran, server error, silahkan hubungi developer.")
                }
            }
            
        }
        
    }
    
    private func checkAllToRegister(){
        if isEmailValid && isPasswordValid && isNameValid && isConfirmPasswordValid && isPhoneValid{
            enableRegister?(true)
        } else{
            enableRegister?(false)
        }
    }
    
    
}
