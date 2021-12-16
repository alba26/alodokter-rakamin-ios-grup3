//
//  RegisterView.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 08/12/21.
//

import UIKit

class RegisterView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var hpValidationLabel: UILabel!
    @IBOutlet weak var passwordRegisterTextField: UITextField!
    @IBOutlet weak var passwordConfirmRegisterTextField: UITextField!
    
    @IBOutlet weak var phoneRegisterTextField: UITextField!
    @IBOutlet weak var passwordConfirmValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var namaValidationLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailRegisterTextField: UITextField!
    @IBOutlet weak var nameRegisterTextField: UITextField!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("RegisterView", owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
        
        passwordRegisterTextField.setCustomUI(withPlaceholder: "Konfirmasi Kata Sandi")
        passwordConfirmRegisterTextField.setCustomUI(withPlaceholder: "Kata Sandi")
        phoneRegisterTextField.setCustomUI(withPlaceholder: "No. HP")
        emailRegisterTextField.setCustomUI(withPlaceholder: "Email")
        nameRegisterTextField.setCustomUI(withPlaceholder: "Nama")
        
        phoneRegisterTextField.keyboardType = .numberPad
    }

}
