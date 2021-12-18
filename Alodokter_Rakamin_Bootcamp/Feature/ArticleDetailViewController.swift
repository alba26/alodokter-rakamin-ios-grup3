//
//  ArticleDetailViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 14/12/21.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var articleDetailView: ArticleDetailView!
    private let viewModel = ArticleDetailViewModel()
    var idArticle = ""
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        viewModel.idArticle = idArticle
        viewModel.getArticleData { [weak self] article in
            DispatchQueue.main.async {
                self?.articleDetailView.articleTitleLabel.text = article.title
                self?.articleDetailView.articleBodyLabel.attributedText = article.content?.htmlAttributedString()
                guard let urlImage = URL(string: article.image), let dataImage = try? Data(contentsOf: urlImage) else { return }
                self?.articleDetailView.articleImageView.image = UIImage(data: dataImage)
            }
        }
    }
}
