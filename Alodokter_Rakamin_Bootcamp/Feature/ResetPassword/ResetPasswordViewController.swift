//
//  ResetPasswordViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 07/12/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var resetPasswordView: ResetPasswordView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.cancelButton.action = #selector(dismissButtonTapped)
    }
    
    @objc func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
