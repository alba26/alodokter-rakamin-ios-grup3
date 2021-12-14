//
//  RegisterViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 08/12/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerView: RegisterView!
    var email:String = ""
    var fullName:String = ""
    var password:String = "" //NEED CHANGE
    var identity:String = ""
    var birth:String = ""
    var phoneNumber:String = ""
    var gender:String = ""
    var address:String = ""
    let utils = Utility()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    
    @objc func register(){
        
        self.email = registerView.emailRegisterTextField.text ?? ""
        self.fullName = registerView.nameRegisterTextField.text ?? ""
        self.password = registerView.passwordRegisterTextField.text ?? ""
        let registerService = RegisterService(email: self.email, fullname: self.fullName, birthdate: "26-10-1998", gender: "Pria", phone: "adwdawdawdawdawdawd", identity: "asdawdawdadwadwawd", address: "awdhkajdhakwdhkadw", password: self.password)
        APIService.APIRequest(model: UserData.self, req: registerService){ [self](result) in
            switch result {
                
            case .success(let user):
                guard let register = user as? UserData else{
                    return
                }
                if register.code == 201{
                    DispatchQueue.main.async {
                        self.dismiss(animated: true){
                            //harus ada notif kalau berhasil
                        }
                    }
                }else{
                    utils.showAlertAction(title: "Pendaftaran Gagal", message: "Gagal untuk melakukan pendaftaran, silahkan coba lagi.", uiview: self)
                }
                
            case .failure(let error):
                print(error) //OUTPUT ERROR
            }
            
        }
    }

}
