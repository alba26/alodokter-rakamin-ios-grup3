//
//  KonfirmasiDataViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

class KonfirmasiDataViewController: UIViewController {
    
    @IBOutlet weak var contentView: KonfirmasiDataView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    @objc func nextButtonPressed() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "BookingSelesai") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
