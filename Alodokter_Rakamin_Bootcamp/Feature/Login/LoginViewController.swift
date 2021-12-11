//
//  LoginViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 08/12/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: LoginView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        
    }
    
    
   @objc func loginButton(){
        let userProfileStoryboard : UIStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
        let userProfileVC = userProfileStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController")
        if UserDefaults().checkSession() == Session.unregistered.rawValue{ //gnti disini
            self.navigationController?.pushViewController(userProfileVC, animated: true)
        }
    }

}

