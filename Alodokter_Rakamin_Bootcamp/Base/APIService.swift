//
//  APIRequest.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Adhitya Laksamana Bayu Adrian on 07/12/21.
//

import Foundation

protocol BaseService{
    func method() -> APIService.Method
    func url() -> URL
    func timeout() -> TimeInterval
    func httpBody() -> [String:String]
    func auth() -> String
}

enum NetworkResult {
    case success(Codable)
    case failure(Error)
}

class APIService{
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    static func APIRequest<T:Codable>(model: T.Type,req: BaseService, completion: @escaping (NetworkResult) -> Void) {
        var request = URLRequest(url: req.url())
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = req.method().rawValue
        request.timeoutInterval = req.timeout()
        if req.httpBody().isEmpty != true{
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: req.httpBody(), options: .prettyPrinted)
            } catch let error {
                completion(.failure(error))
            }
        }
        
        if req.auth() != ""{
            request.setValue(req.auth(), forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error!))
                return
            }
            do{
                let response = try JSONDecoder().decode(model.self, from: data)
                completion(.success(response))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
}
