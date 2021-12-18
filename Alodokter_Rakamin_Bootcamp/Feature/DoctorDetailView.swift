//
//  DoctorDetailView.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 18/12/21.
//

import UIKit

class DoctorDetailView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationContainer: UIView!
    @IBOutlet weak var appointmentButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("DoctorDetailView", owner: self, options: nil)
        contentView.frame = self.bounds
        imageView.circleView()
        locationContainer.layer.shadowColor = UIColor.gray.cgColor
        locationContainer.layer.shadowOpacity = 0.4
        locationContainer.layer.shadowOffset = .zero
        locationContainer.layer.shadowRadius = 3
        locationContainer.layer.cornerRadius = 10
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

}
