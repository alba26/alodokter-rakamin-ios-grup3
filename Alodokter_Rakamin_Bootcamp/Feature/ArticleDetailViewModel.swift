//
//  ArticleDetailViewModel.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import Foundation

class ArticleDetailViewModel {
    var idArticle = ""
    
    func getArticleData(completion: @escaping (Article) -> Void) {
        let request = ArticleDetailService(idArticle: idArticle)
        APIService.APIRequest(model: ArticleDetailsModel.self, req: request) { result in
            switch result {
            case .success(let result):
                guard let safeResult = result as? ArticleDetailsModel else { return }
                completion(safeResult.data)
            case.failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
