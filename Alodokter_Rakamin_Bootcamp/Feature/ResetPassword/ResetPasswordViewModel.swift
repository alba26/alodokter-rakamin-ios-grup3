//
//  ResetPasswordViewModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 14/12/21.
//

import Foundation

class ResetPasswordViewModel {
    var oldPassword: String?
    var newPassword: String?
    var confirmPassword: String?
    var idUser: String?
    
    func passwordConfirmed() -> Bool {
        if confirmPassword == newPassword {
            return true
        } else {
            return false
        }
    }
    
    func resetPassword(completion: @escaping (String) -> Void) {
        guard let oldPassword = oldPassword, let newPassword = newPassword, let idUser = idUser else { return }

        let request = ResetPasswordService(oldPassword: oldPassword, newPassword: newPassword, idUser: idUser)
        if passwordConfirmed() {
            APIService.APIRequest(model: UserData.self, req: request) { result in
                switch result {
                case .success(let result):
                    guard let safeResult = result as? UserData else { return }
                    completion(safeResult.message)
                case.failure(let error):
                    print("Error: \(error)")
                }
            }
        } else {
            completion("Pastikan kata sandi sama")
        }
    }
}
