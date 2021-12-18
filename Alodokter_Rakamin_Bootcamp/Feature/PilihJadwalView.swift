//
//  PilihJadwalView.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

class PilihJadwalView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tanggalTextField: UITextField!
    @IBOutlet weak var jamTextField: UITextField!
    @IBOutlet weak var pilihJadwalCard: UIView!
    @IBOutlet weak var detailDokterCard: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("PilihJadwalView", owner: self, options: nil)
        contentView.frame = self.bounds
        nextButton.setCustomUI(color: .orange, title: "Tetapkan Jadwal")
        tanggalTextField.setCustomUI(withPlaceholder: nil)
        jamTextField.setCustomUI(withPlaceholder: nil)
        pilihJadwalCard.cardView()
        detailDokterCard.cardView()
        imageView.circleView()
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
