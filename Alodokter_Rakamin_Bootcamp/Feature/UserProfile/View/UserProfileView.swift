//
//  UserProfileView.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 09/12/21.
//

import UIKit

class UserProfileView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var accountContainer: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var logoutContainer: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var myData: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var history: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("UserProfileView", owner: self, options: nil)
        contentView.frame = self.bounds
        accountContainer.layer.shadowColor = UIColor.gray.cgColor
        accountContainer.layer.shadowOpacity = 0.4
        accountContainer.layer.shadowOffset = .zero
        accountContainer.layer.shadowRadius = 3
        accountContainer.layer.cornerRadius = 10
        
        logoutContainer.layer.shadowColor = UIColor.gray.cgColor
        logoutContainer.layer.shadowOpacity = 0.4
        logoutContainer.layer.shadowOffset = .zero
        logoutContainer.layer.shadowRadius = 3
        logoutContainer.layer.cornerRadius = 10
        
        userImage.layer.cornerRadius = userImage.frame.width/2
        userImage.clipsToBounds = true
        
        addSubview(contentView)
    }
}
