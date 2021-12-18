//
//  BookingBerhasilView.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

class BookingSelesaiView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var finishButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("BookingSelesaiView", owner: self, options: nil)
        contentView.frame = self.bounds
        finishButton.setCustomUI(color: .orange, title: "Kembali")
        self.addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
}
