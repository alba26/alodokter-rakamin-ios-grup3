//
//  ArticleViewModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by aurelia natasha on 14/12/21.
//

import Foundation

struct ArticleViewModel {
    
    let utils = Utility()
    let articleVC = ArticleViewController()
    var articlesData: ArticleModel
    
    func getArticlesData() {
        let articleService = ArticleService()
        APIService.APIRequest(model: ArticleModel.self, req: articleService) { [self] (articles) in
        switch(articles) {
        case .success(let articles):
                DispatchQueue.main.async {
                   // articlesData.listOfArticles = articles as! [Article]
                    
        }
                
        case .failure(_):
            failToLoadArticle(title: "Load Artikel Gagal", message: "Terdapat kendala load artikel")
        }
            
            
            
        }
    }
    
    private func failToLoadArticle(title: String, message:String){
        DispatchQueue.main.async { [self] in
            utils.showAlertAction(title: title, message: message, uiview: articleVC)
            articleVC.view.isUserInteractionEnabled = true
        }
    }
}
