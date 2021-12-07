//
//  LoginView.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 08/12/21.
//

import UIKit

class LoginView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBAction func authButton(_ sender: Any) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
    }
}
