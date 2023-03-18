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

struct PrepResponse: Codable {
    let message: String
}

struct SignUpOptions: Codable {
    let options: Options
    enum CodingKeys: String, CodingKey {
        case options = "Options"
    }
}

struct Options: Codable {
    let goals: [OptionList]
    let diets: [OptionList]
    let allergens: [OptionList]
    enum CodingKeys: String, CodingKey {
        case goals = "Goals"
        case diets = "Diets"
        case allergens = "Allergens"
    }
}

struct OptionList: Codable {
    let id: Int
    let option: String
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case option = "Option"
    }
}

enum PrepApi: String {
    case sendOtp = "sendotp"
    case verifyOtp = "verifyotp"
}

class HttpClient {
    func request(api: PrepApi, data: String, completionHandler: @escaping (Result<PrepResponse,Error>) -> Void) {
        let endPoint = "https://ws1.mymacrohero.com/api/" + api.rawValue + "/" + data
        print("endPoint:\(endPoint)")
        guard let url = URL(string: endPoint) else {
            completionHandler(.failure(HttpClientError.badURL))
            return
        }
        var request = URLRequest(url: url)
        if api == .sendOtp {
            request.httpMethod = "POST"
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
            print("Client data received \(String(describing: String(data: data, encoding: .utf8)))")
            let decoder = JSONDecoder()
            do {
                print("Client data received\(data)")
                let response = try decoder.decode(PrepResponse.self, from: data)
                completionHandler(.success(response))
            } catch let error {
                print("error:\(error)")
                completionHandler(.failure(HttpClientError.unknownError))
            }
        }
        urlSessionDataTask.resume()
    }
    func fetch(completionHandler: @escaping (Result<SignUpOptions,Error>) -> Void) {
        let endPoint = "https://ws1.mymacrohero.com/api/signup/options"
        print("endPoint:\(endPoint)")
        guard let url = URL(string: endPoint) else {
            completionHandler(.failure(HttpClientError.badURL))
            return
        }
        let request = URLRequest(url: url)
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
            print("Client data received \(String(describing: String(data: data, encoding: .utf8)))")
            let decoder = JSONDecoder()
            do {
                print("Client data received\(data)")
                let response = try decoder.decode(SignUpOptions.self, from: data)
                completionHandler(.success(response))
            } catch let error {
                print("error:\(error)")
                completionHandler(.failure(HttpClientError.unknownError))
            }
        }
        urlSessionDataTask.resume()
    }
}
