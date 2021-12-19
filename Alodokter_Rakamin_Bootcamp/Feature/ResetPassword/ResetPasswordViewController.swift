//
//  ResetPasswordViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 07/12/21.
//

import UIKit

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var resetPasswordView: ResetPasswordView!
    var userId: String?
    let viewModel = ResetPasswordViewModel()
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.cancelButton.action = #selector(dismissButtonTapped)
        resetPasswordView.saveButton.addTarget(self, action: #selector(saveNewPassword), for: .touchUpInside)
        textFieldDelegate()
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
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @objc func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    
    private func textFieldDelegate(){
        resetPasswordView.oldPasswordTextField.returnKeyType = .done
        resetPasswordView.newPasswordTextField.returnKeyType = .done
        resetPasswordView.confirmPasswordTextField.returnKeyType = .done
        
        resetPasswordView.oldPasswordTextField.delegate = self
        resetPasswordView.newPasswordTextField.delegate = self
        resetPasswordView.confirmPasswordTextField.delegate = self
    }
}
