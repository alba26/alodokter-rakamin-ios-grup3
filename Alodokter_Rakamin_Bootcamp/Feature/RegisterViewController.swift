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
        
        registerVM.registerSuccess = { [self] msg in
            DispatchQueue.main.async {
                spinner.dismiss(animated: true, completion: {
                    utils.showAlertAction(title: "Pendaftaran Berhasil", message: msg ?? "Silahkan Login.", uiview: self, action: true)
                })

                registerView.isUserInteractionEnabled = true
            }
        }
        
        registerVM.registerFailed = { [self] msg in
            DispatchQueue.main.async {
                spinner.dismiss(animated: true, completion: {
                    utils.showAlertAction(title: "Pendaftaran Gagal", message: msg ?? "", uiview: self)
                })
                registerView.isUserInteractionEnabled = true
                
            }
            
        }
    }
    @objc func register(){
        registerVM.register(email:  registerView.emailRegisterTextField.text ?? "", fullname: registerView.nameRegisterTextField.text ?? "", password: registerView.passwordRegisterTextField.text ?? "")
        self.present(spinner, animated: true, completion: nil)
    }
    


}



//self.email = registerView.emailRegisterTextField.text ?? ""
//self.fullName = registerView.nameRegisterTextField.text ?? ""
//self.password = registerView.passwordRegisterTextField.text ?? ""
//let registerService = RegisterService(email: self.email , fullname: self.fullName, phone: "08111111111", password: self.password)
//
//registerView.isUserInteractionEnabled = false
//APIService.APIRequest(model: UserData.self, req: registerService){ [self](result) in
//    switch result {
//    case .success(let user):
//        guard let register = user as? UserData else{
//            return
//        }
//        if register.code == 201{
//            DispatchQueue.main.async {
//                utils.showAlertAction(title: "Pendaftaran Berhasil", message: "Silahkan Login.", uiview: self)
//                registerView.isUserInteractionEnabled = true
//            }
//        }else{
//            DispatchQueue.main.async {
//                utils.showAlertAction(title: "Pendaftaran Gagal", message: "Gagal untuk melakukan pendaftaran, silahkan coba lagi.", uiview: self)
//                registerView.isUserInteractionEnabled = true
//            }
//
//        }
//
//    case .failure(_):
//        DispatchQueue.main.async {
//            utils.showAlertAction(title: "Pendaftaran Gagal", message: "Gagal untuk melakukan pendaftaran, server error, silahkan hubungi developer.", uiview: self)
//            registerView.isUserInteractionEnabled = true
//        }
//    }
//
//}
