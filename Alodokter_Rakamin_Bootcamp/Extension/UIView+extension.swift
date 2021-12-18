//
//  UIView+extension.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

extension UIView {
    func cardView() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
        self.layer.cornerRadius = 10
    }
    
    func circleView() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
