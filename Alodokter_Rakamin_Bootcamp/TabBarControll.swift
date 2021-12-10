//
//  TabBarControll.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 09/12/21.
//

import Foundation
import UIKit

class TabBarControll: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let selectedTab = item.title else {
            return
        }
        if selectedTab == "Item"{
            print("Booking")
        }
        
    }
}
