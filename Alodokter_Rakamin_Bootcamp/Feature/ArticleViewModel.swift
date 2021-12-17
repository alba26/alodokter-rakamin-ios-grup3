//
//  ArticleViewModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by aurelia natasha on 14/12/21.
//

import Foundation

class ArticleViewModel {
    
    let utils = Utility()

    func getArticlesData() {
        let articleService = ArticleService(param: "per_page",value: 2)
        APIService.APIRequest(model: ArticlesModel.self, req: articleService) { (results) in
        switch(results) {
        case .success(let results):
            guard let articlesData  = results as? ArticlesModel else {
                return
            }
            print(articlesData)
            
                
        case .failure(let error):
//            failToLoadArticle(title: "Load Artikel Gagal", message: "Terdapat kendala load artikel")
            print(error,"error")
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
