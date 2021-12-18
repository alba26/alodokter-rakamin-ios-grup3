//
//  OnboardingCollectionViewCell.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 18/12/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
