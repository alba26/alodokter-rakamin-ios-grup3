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
    var firstName:String = ""
    var password:String = "" //NEED CHANGE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    
    @objc func register(){
        
        self.email = registerView.emailRegisterTextField.text ?? ""
        self.firstName = registerView.nameRegisterTextField.text ?? ""
        self.password = registerView.passwordRegisterTextField.text ?? ""
        let registerService = RegisterService(email: self.email, firstname: self.firstName, lastname: "ios", birthdate: "adwawdadawddwad", gender: "Pria", phone: "adwdawdawdawdawdawd", identity: "asdawdawdadwadwawd", address: "awdhkajdhakwdhkadw", city: "fawkjjbdwakjd", password: self.password)
        print(registerService.password)
        APIService.APIRequest(model: UserData.self, req: registerService){ [self](result) in
            switch result {
                
            case .success(let user):
                guard let register = user as? UserData else{
                    return
                }
                if register.code == 201{
                    DispatchQueue.main.async {
                        self.dismiss(animated: true){
                            
                        }
                    }
                }else{
                    print("GAGAL Mendaftar")
                }
                
            case .failure(let error):
                print(error) //OUTPUT ERROR
            }
            
        }
    }

}
