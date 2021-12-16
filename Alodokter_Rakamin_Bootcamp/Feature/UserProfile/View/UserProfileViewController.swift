//
//  UserProfileViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 09/12/21.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userProfileView: UserProfileView!
    var userLabelName = ""
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileView.resetPasswordButton.addTarget(self, action: #selector(resetPasswordTapped), for: .touchUpInside)
        userProfileView.logout.addTarget(self, action: #selector(logout), for: .touchUpInside)
        userProfileView.myData.addTarget(self, action: #selector(seeMyData), for: .touchUpInside)
        
        if UserDefaults().checkIsUserLogin(){
            decodeUserData()
        }

        NotificationCenter.default.addObserver(self, selector: #selector(changeLabelImageName), name: NSNotification.Name(rawValue: "changeNameLabel"), object: nil)
    }
    
    @objc func resetPasswordTapped() {
        let storyboard = UIStoryboard.init(name: "ResetPassword", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ResetPasswordView") as? ResetPasswordViewController else { return }
        vc.userId = userId
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func logout(){
        UserDefaults.standard.set(Session.unregistered.rawValue, forKey: "session")
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.set("", forKey: "userdata")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func seeMyData(){
        if UserDefaults().checkIsUserLogin(){
            let myDataStoryboard : UIStoryboard = UIStoryboard(name: "ChangeData", bundle: nil)
            let myDataVC = myDataStoryboard.instantiateViewController(withIdentifier: "ChangeDataViewController")
            self.present(myDataVC, animated: true){
            }
        }
    }
}

extension UserProfileViewController{
    
    //NEED IMPROVEMENT
   private func decodeUserData(){
        if let data = UserDefaults.standard.data(forKey: "userdata"){
            do{
                let decoder = JSONDecoder()
                let userdata = try decoder.decode(UserProfile.self, from: data)
                userId = String(userdata.id)
                userLabelName = userdata.fullname
                userProfileView.nameLabel.text = userdata.fullname
            }catch{
                print(error)
            }
        }
    }
    
    @objc func changeLabelImageName(notification: NSNotification){
        if let data = UserDefaults.standard.data(forKey: "userdata"){
            do{
                let decoder = JSONDecoder()
                let userdata = try decoder.decode(UserProfile.self, from: data)
                userLabelName = userdata.fullname
                DispatchQueue.main.async { [self] in
                    userProfileView.nameLabel.text = userdata.fullname
                }
            }catch{
                print(error)
            }
        }
        
        
    }
}
