//
//  Exten.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 07/12/21.
//

import Foundation
import UIKit
extension UINavigationController {
public func popToSelectedController(destinationController: AnyClass) {
    var index = 0
    for i in 0 ..< viewControllers.count {
        let controller: AnyObject = viewControllers[i]
        if controller.isKind(of:destinationController) {
            index = i
            break
        }
    }
    popToViewController(viewControllers[index] , animated: true)
    }
}
