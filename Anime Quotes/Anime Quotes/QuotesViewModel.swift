//
//  QuotesViewModel.swift
//  Anime Quotes
//
//  Created by Leo Nugraha on 2022/6/10.
//

import Foundation

final class QuotesViewModel: NSObject {

    @Published public var quoteList: Array<QuotesModel> = [QuotesModel]()

    public func sendApiRequest(completionHandler: @escaping((Result<QuotesModel, Error>)->(Void))) {
        let url = URL(string: API_ENDPOINT_URL)
        var urlRequest: URLRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept-Encoding")

        // let semaphore = DispatchSemaphore(value: 0)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                // completionHandler(.failure(.responseProblem))
                return
            }

            do {
                let messageData = try JSONDecoder().decode(QuotesModel.self, from: jsonData)
                completionHandler(.success(messageData))
            } catch {
                // completionHandler(.failure(.decodingProblem))
            }

            // semaphore.signal()
        }
        dataTask.resume()
        // semaphore.wait()

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
