//
//  BookingViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

class BookingViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func testButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PilihJadwal") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
