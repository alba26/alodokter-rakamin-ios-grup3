//
//  ResetPasswordPage.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 07/12/21.
//

import UIKit

class ResetPasswordView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ResetPasswordView", owner: self, options: nil)
        contentView.frame = self.bounds
        saveButton.setCustomUI(color: .orange, title: "Simpan")
        oldPasswordTextField.setCustomUI(withPlaceholder: "Kata sandi lama")
        newPasswordTextField.setCustomUI(withPlaceholder: "Min. 8 karakter")
        confirmPasswordTextField.setCustomUI(withPlaceholder: "Konfirmasi kata sandi")
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
