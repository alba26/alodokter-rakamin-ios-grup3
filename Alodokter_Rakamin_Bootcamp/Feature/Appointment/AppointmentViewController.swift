//
//  AppointmentViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Finsen Antonius on 16/12/21.
//

import UIKit

class AppointmentViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var latestAppointmentView: LatestAppointmentView!
    @IBOutlet weak var completedAppointmentView: CompletedAppointmentView!
    
    @IBAction func switchMenu(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            latestAppointmentView.isHidden = false
            completedAppointmentView.isHidden = true
            break
        case 1:
            latestAppointmentView.isHidden = true
            completedAppointmentView.isHidden = false
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completedAppointmentView.isHidden = true
       
    }
    
}
