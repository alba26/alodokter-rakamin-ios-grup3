//
//  BookingSelesaiViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

class BookingSelesaiViewController: UIViewController {

    @IBOutlet weak var contentView: BookingSelesaiView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
    }

    @objc func finishButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
