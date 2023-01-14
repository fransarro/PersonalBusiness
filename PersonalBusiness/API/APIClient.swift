//
//  APIClient.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

protocol APIClientProtocol {
    func getTransactions(completion : @escaping (Result<Transactions, Error>) -> ())
    func getRates(completion : @escaping (Result<Rates, Error>) -> ())
}

class APIClient : APIClientProtocol {
    
    // MARK: GenericRequest
    private func performRequest<T:Decodable>(url:String, decoder: JSONDecoder = JSONDecoder(), parameters : [String :Any]?  = nil ,completion:@escaping (Result<T,Error>)->Void)  {
        
        guard let url = URL(string: url) else {return}
        
        let request = URLRequest(url: url)
        
        if let _ = parameters {
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(responseData))
            }
            catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    
    // MARK: GetTransactionRequest
    func getTransactions(completion :  @escaping (Result<Transactions, Error>) -> ()) {
        performRequest(url: BaseURLS().getURLStringByPath(path: .transactions)) { result in
            completion(result)
        }
    }
    
    // MARK: GetRatesRequest
    func getRates(completion :  @escaping (Result<Rates, Error>) -> ()) {
        performRequest(url: BaseURLS().getURLStringByPath(path: .rates)) { result in
            completion(result)
        }
    }
    
}
