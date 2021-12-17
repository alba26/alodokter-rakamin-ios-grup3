//
//  CustomButton.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 07/12/21.
//

import UIKit

extension UIButton {
    enum ButtonColor: String {
        case orange = "SecondaryColor", blue = "PrimaryColor"
    }
    
    func setCustomUI(color: ButtonColor, title: String) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = UIColor(named: color.rawValue)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
