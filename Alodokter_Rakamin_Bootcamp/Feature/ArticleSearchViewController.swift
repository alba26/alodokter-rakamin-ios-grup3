//
//  ArticleSearchViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by aurelia natasha on 16/12/21.
//

import UIKit

class ArticleSearchViewController: UIViewController {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    var searchArticleResult : [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

    }
}


extension ArticleSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArticleResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! ArticleSearchTableViewCell
        cell.articleSearchImage.image = UIImage(named: "ArticleImage")
        cell.articleSearchTitleLabel.text = searchArticleResult![indexPath.row].title
        
        return cell
    }
}

