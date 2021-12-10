//
//  UserProfileViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 09/12/21.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userProfileView: UserProfileView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileView.resetPasswordButton.addTarget(self, action: #selector(resetPasswordTapped), for: .touchUpInside)
    }
    
    @objc func resetPasswordTapped() {
        let storyboard = UIStoryboard.init(name: "ResetPassword", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ResetPasswordView") as? ResetPasswordViewController else { return }
        self.present(vc, animated: true, completion: nil)
    }

}
