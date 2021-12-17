//
//  ArticleDetailViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 14/12/21.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var articleDetailView: ArticleDetailView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
