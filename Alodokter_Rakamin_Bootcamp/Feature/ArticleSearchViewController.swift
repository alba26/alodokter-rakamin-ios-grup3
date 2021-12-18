//
//  ArticleSearchViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by aurelia natasha on 16/12/21.
//

import UIKit

class ArticleSearchViewController: UIViewController {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    var testArr = ["test 1", "test 2"]
    var searchArticleResult : [Article]?
//    var articleVC = ArticleViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


extension ArticleSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchArticleResult?.count ?? 0
        return testArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! ArticleSearchTableViewCell
//        cell.articleSearchImage.image = UIImage(named: "ArticleImage")
        cell.articleSearchTitleLabel.text = testArr[indexPath.row]
        
        return cell
    }
}

