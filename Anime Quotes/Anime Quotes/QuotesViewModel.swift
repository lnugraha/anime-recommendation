//
//  QuotesViewModel.swift
//  Anime Quotes
//
//  Created by Leo Nugraha on 2022/6/10.
//

import Foundation

final class QuotesViewModel: NSObject {

    @Published public var quoteList: Array<QuotesModel> = [QuotesModel]()

    public func sendApiRequest() {
        
    }
    
}

extension URLSession {

    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }

    public func request<T: Codable>(url: URL?,
                                    expecting: T.Type,
                                    completionHandler: @escaping(Result<T, Error>)->Void) {
        
        guard let url = url else {
            completionHandler(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = dataTask(with: url) { data, _, error in

            guard let data = data else {
                if let error = error {
                    completionHandler(.failure(error))
                } else {
                    completionHandler(.failure(CustomError.invalidData))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }

        }

        task.resume()
    }
    
    
}
