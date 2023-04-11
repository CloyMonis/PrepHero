//
//  HttpClient.swift
//  PrepHero
//
//  Created by Cloy Vserv on 25/02/23.
//

import Foundation

enum HttpClientError: Error {
    case badURL
    case unknownError
    case errorHttpResponse
    case notFound
    case unknownResponseCode
    case invalidData
}

enum HttpMethod: String {
    case get
    case post
}

enum PrepApi: String {
    case sendOtp = "sendotp"
    case verifyOtp = "verifyotp"
    case signUpOptions = "signup/options"
    case signUpResult = "signup/getresult"
}

class HttpClient {
    func request(api: PrepApi, httpMethod: HttpMethod = .get, body: Data? = nil, completionHandler: @escaping (Result<Data,Error>) -> Void) {
        let endPoint = "https://ws1.mymacrohero.com/api/" + api.rawValue
        print("endPoint:\(endPoint)")
        guard let url = URL(string: endPoint) else {
            completionHandler(.failure(HttpClientError.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let body = body {
            request.httpBody = body
        }
        let urlSessionDataTask = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard error == nil else {
                completionHandler(.failure(HttpClientError.unknownError))
                return
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completionHandler(.failure(HttpClientError.errorHttpResponse))
                return
            }
            if httpResponse.statusCode == 404 {
                completionHandler(.failure(HttpClientError.notFound))
                return
            }
            if httpResponse.statusCode != 200 {
                print("\(httpResponse.statusCode)")
                completionHandler(.failure(HttpClientError.unknownResponseCode))
                return
            }
            guard let data = data else {
                completionHandler(.failure(HttpClientError.invalidData))
                return
            }
            // print("Client data received \(String(describing: String(data: data, encoding: .utf8)))")
            completionHandler(.success(data))
        }
        urlSessionDataTask.resume()
    }
}
