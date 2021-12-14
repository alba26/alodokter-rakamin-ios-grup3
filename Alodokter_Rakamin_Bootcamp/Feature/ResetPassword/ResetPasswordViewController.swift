//
//  ResetPasswordViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 07/12/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var resetPasswordView: ResetPasswordView!
    var userId: String?
    let viewModel = ResetPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.cancelButton.action = #selector(dismissButtonTapped)
        resetPasswordView.saveButton.addTarget(self, action: #selector(saveNewPassword), for: .touchUpInside)
    }
    
    @objc func saveNewPassword() {
        viewModel.idUser = self.userId
        viewModel.oldPassword = resetPasswordView.oldPasswordTextField.text
        viewModel.newPassword = resetPasswordView.newPasswordTextField.text
        viewModel.confirmPassword = resetPasswordView.confirmPasswordTextField.text
        viewModel.resetPassword { result in
            if result != "success" {
                Utility().showAlertAction(title: result.capitalized, message: result.capitalized, uiview: self)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @objc func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
