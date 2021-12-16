//
//  ArticleSearchViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by aurelia natasha on 16/12/21.
//

import UIKit

class ArticleSearchViewController: UIViewController {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        self.searchResultTableView.delegate = self
//        self.searchResultTableView.dataSource = self

    }

}

extension ArticleSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! ArticleSearchTableViewCell
        cell.articleSearchImage.image = UIImage(named: "ArticleImage")
        cell.articleSearchTitleLabel.text = "4 Manfaat Daun"
        
        return cell
    }
    
    
}
