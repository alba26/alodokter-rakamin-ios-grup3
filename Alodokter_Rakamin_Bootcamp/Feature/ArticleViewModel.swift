//
//  ArticleViewModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by aurelia natasha on 14/12/21.
//

import Foundation

class ArticleViewModel {
    
    let utils = Utility()
    var listOfArticle: [Article]?
    
    func getArticlesData() {
        let articleService = ArticleService()
        APIService.APIRequest(model: ArticleModel.self, req: articleService) { (results) in
        switch(results) {
        case .success(let results):
            guard let articlesData  = results as? ArticleModel else {
                return
            }
            self.listOfArticle = articlesData.listOfArticles
            
                
        case .failure(_):
//            failToLoadArticle(title: "Load Artikel Gagal", message: "Terdapat kendala load artikel")
            print("error")
        }
            
            
            
        }
    }
    
//    private func failToLoadArticle(title: String, message:String){
//        DispatchQueue.main.async { [self] in
//            utils.showAlertAction(title: title, message: message, uiview: articleVC)
//            articleVC.view.isUserInteractionEnabled = true
//        }
//    }
}
