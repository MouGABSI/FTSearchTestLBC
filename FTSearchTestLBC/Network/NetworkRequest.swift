//
//  NetworkRequest.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation

public enum HttpMethod : String {
    case get     = "GET"
    case post    = "POST"
    case delete  = "DELETE"
    case put     = "PUT"
    case patch   = "PATCH"
}

public protocol NetworkRequest {
    var baseURL: URL? { get }
    var path: String? { get }
    var method: HttpMethod? { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
    var encoder: ParameterEncoder? { get }
    var retryPolicy: RetryPolicy { get }
}

public protocol RetryPolicy {
    var maxRetries: Int { get }
    var retryInterval: TimeInterval { get }
}

public protocol NetworkSessionProtocol {
    associatedtype EndPoint: NetworkRequest
    func sendRequest<T>(_ request: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable
    func buildURLRequest(from request: EndPoint) throws -> URLRequest?
}

struct NetworkSession<EndPoint:NetworkRequest>: NetworkSessionProtocol {
    
    func sendRequest<T>(_ request: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        do {
            let urlRequest = try buildURLRequest(from: request)
            if let _request = urlRequest {
                send(_request, retriesLeft: request.retryPolicy.maxRetries, retryInterval: request.retryPolicy.retryInterval, completion: completion)
            } else {
                completion(.failure(.badRequest("empty Request Fields")))
            }
            
        }catch {
            completion(.failure(.encodingFailed))
        }
    }
    
    private func send<T: Decodable>(_ urlRequest: URLRequest, retriesLeft: Int, retryInterval: TimeInterval, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                if retriesLeft > 0 {
                    DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval) {
                        self.send(urlRequest, retriesLeft: retriesLeft - 1, retryInterval: retryInterval, completion: completion)
                    }
                } else {
                    completion(.failure(.requestFailed(error)))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(.invalidResponse))
            }
            switch httpResponse.statusCode {
                case 200...299:
                    guard let data = data else {
                        return completion(.failure(.invalidData))
                    }
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch let error {
                        completion(.failure(.decodingFailed(error)))
                    }
                case 401:
                    completion(.failure(.unauthorized))
                case 500...599:
                    if retriesLeft > 0 {
                        DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval) {
                            self.send(urlRequest, retriesLeft: retriesLeft - 1, retryInterval: retryInterval, completion: completion)
                        }
                    } else {
                        completion(.failure(.serverError(statusCode: httpResponse.statusCode, message: parseErrorMessage(data: data))))
                    }
                default:
                    completion(.failure(.unknown(error)))
            }
        }.resume()
    }
    
    func buildURLRequest(from request: EndPoint) throws -> URLRequest? {
        guard let baseURL = request.baseURL, let path = request.path, let httpMethod = request.method, let parametersEncoder = request.encoder else {
            print("empty Request items")
            return nil
        }
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        urlRequest.httpMethod = httpMethod.rawValue
        do {
            try parametersEncoder.encode(urlRequest: &urlRequest, with: request.parameters)
            return urlRequest
        } catch {
            throw error
        }
    }
    
    private func parseErrorMessage(data: Data?) -> String {
        if let data = data, let errorMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let message = errorMessage["message"] as? String {
            return message
        } else {
            return "Unknown error"
        }
    }
}
