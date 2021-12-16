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
    
    func register(email: String, fullname: String, password:String){
        let registerService = RegisterService(email: email , fullname: fullname, phone: "08111111111", password: password)
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
                        registerFailed?("Gagal untuk melakukan pendaftaran, silahkan coba lagi.")
                    }

                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    registerFailed?("Gagal untuk melakukan pendaftaran, server error, silahkan hubungi developer.")
                }
            }
            
        }
        
    }
    
    
}
