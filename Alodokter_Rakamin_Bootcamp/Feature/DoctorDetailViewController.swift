//
//  DoctorDetailViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 18/12/21.
//

import UIKit

class DoctorDetailViewController: UIViewController {

    
    @IBOutlet weak var DoctorDetailView: DoctorDetailView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
        self.addKeyboardObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DoctorDetailView.appointmentButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func nextButtonTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PilihJadwal") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
