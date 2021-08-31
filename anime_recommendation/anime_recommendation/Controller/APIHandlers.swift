//
//  APIHandlers.swift
//  anime_recommendation
//
//  Created by Leo Nugraha on 2021/8/30.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
}

class APIHandlers {

    public class func getAnimeListFromPage(pageNumber: Int=1, completionHandler: @escaping( (Result<[AnimeProperties],APIError>) -> Void)) {

        let fullURL = GET_API_URL + "\(String(pageNumber))"
        let url = URL(string: fullURL)
        var urlRequest: URLRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept-Encoding")

        let semaphore = DispatchSemaphore(value: 0)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completionHandler(.failure(.responseProblem))
                return
            }

            do {
                let messageData = try JSONDecoder().decode(GeneralEntry.self, from: jsonData)
                let finalData = messageData.top // Only retrieve the anime list array only
                completionHandler(.success(finalData))
            } catch {
                completionHandler(.failure(.decodingProblem))
            }

            semaphore.signal()
        }
        dataTask.resume()
        semaphore.wait()
    }

}
