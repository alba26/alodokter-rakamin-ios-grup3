//
//  IsiDataPasienView.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

class IsiDataPasienView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var namaTextField: UITextField!
    @IBOutlet weak var tanggalLahirTextField: UITextField!
    @IBOutlet weak var jenisKelaminTextField: UITextField!
    @IBOutlet weak var ktpTextField: UITextField!
    @IBOutlet weak var pesanUntukCard: UIView!
    @IBOutlet weak var alamatTextField: UITextField!
    @IBOutlet weak var detailPasienCard: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("IsiDataPasienView", owner: self, options: nil)
        contentView.frame = self.bounds
        nextButton.setCustomUI(color: .orange, title: "Simpan Data Pasien")
        namaTextField.setCustomUI(withPlaceholder: nil)
        tanggalLahirTextField.setCustomUI(withPlaceholder: nil)
        jenisKelaminTextField.setCustomUI(withPlaceholder: nil)
        ktpTextField.setCustomUI(withPlaceholder: nil)
        alamatTextField.setCustomUI(withPlaceholder: nil)
        imageView.circleView()
        pesanUntukCard.cardView()
        detailPasienCard.cardView()
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
