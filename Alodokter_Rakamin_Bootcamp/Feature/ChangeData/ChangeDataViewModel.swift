//
//  ChangeDataViewModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 18/12/21.
//

import Foundation

class ChangeDataViewModel{
    
    var changeDataSuccess: ((String?) -> Void)?
    var changeDataFailed: ((String?) -> Void)?
    
    
    func changeData(token: String , id: Int, email: String, fullname: String, birthdate: String , gender: String, phone: String, identity: String, address: String){
        
    let changeService = ChangeDataService(token: token, id: id, gender: gender, birthdate: birthdate, address: address, identity: identity, email: email, phone: phone, fullname: fullname)
        
        APIService.APIRequest(model: UserData.self, req: changeService){ [self](result) in
            switch result {
            case .success(let user):
                guard let register = user as? UserData else{
                    return
                }
                if register.code == 200{
                    DispatchQueue.main.async {
                        do{
                            let encoder = JSONEncoder()
                            let data = try encoder.encode(register.data)
                            UserDefaults.standard.set(data, forKey: "userdata")
                            changeDataSuccess?("Sukses ubah data")
                        }catch{
                            changeDataSuccess?("Silahkan reload")
                        }

                    }
                }else{
                    DispatchQueue.main.async {
                        changeDataFailed?(register.message)
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    changeDataFailed?("Gagal untuk melakukan pendaftaran, server error, silahkan hubungi developer.")
                }
            }
            
        }
        
    }
    
    
    
    
}
