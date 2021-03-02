//
//  APIManager.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//

import Foundation

extension HTTPURLResponse {
    var isResponseOK: Bool {
        return (200...299).contains(statusCode)
    }
    
    var isResponseBadRequest: Bool{
        return statusCode == 400
    }
    
    var isResponseAuthTokenFailed: Bool{
        return statusCode == 401
    }
}

struct HttpMethodType {
    static let GET = "GET"
    static let POST = "POST"
}
enum APIRequestType{
    case postRequest
    case postArrayRequest
    case postImageRequest
    case getRequest
}
enum APIError: Error {
    case missingData
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

final class APIManager{
    
    static let shared = APIManager()
    
    
    lazy var defaultSession: URLSession = {
        URLSession(configuration: .default,
                   delegate: nil,
                   delegateQueue: nil)
    }()
    
    typealias SerializationFunction<T> = (Data?, URLResponse?, Error?) -> Result<T>
    
    private func serializeJSON<T: Decodable>(with data: Data?, response: URLResponse?, error: Error?) -> Result<T> {
        if let error = error { return .failure(error) }
        guard let data = data else { return .failure(APIError.missingData) }
        do {
            let serializedValue = try JSONDecoder().decode(T.self, from: data)
            return .success(serializedValue)
        } catch let error {
            return .failure(error)
        }
    }
    
    @discardableResult
    private func getRequest<T>(_ url: URL, serializationFunction: @escaping SerializationFunction<T>, completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask {
        let dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse, response.isResponseOK{
                let result: Result<T> = serializationFunction(data, response, error)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    @discardableResult
    func getRequest<T: Decodable>(_ url: URL, completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask {
        return getRequest(url, serializationFunction: serializeJSON, completion: completion)
    }
}
