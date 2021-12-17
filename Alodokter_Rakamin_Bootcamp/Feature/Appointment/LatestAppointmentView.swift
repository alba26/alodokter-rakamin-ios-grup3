//
//  LatestAppointmentView.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 16/12/21.
//

import UIKit

class LatestAppointmentView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var appointmentCard: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("LatestAppointmentView", owner: self, options: nil)
        contentView.frame = self.bounds
        
        appointmentCard.layer.shadowColor = UIColor.gray.cgColor
        appointmentCard.layer.shadowOpacity = 0.5
        appointmentCard.layer.shadowOffset = .zero
        appointmentCard.layer.shadowRadius = 3
        appointmentCard.layer.cornerRadius = 10
        
        doctorImage.layer.cornerRadius = doctorImage.frame.width/2
        doctorImage.clipsToBounds = true
        
        addSubview(contentView)
    }

}
