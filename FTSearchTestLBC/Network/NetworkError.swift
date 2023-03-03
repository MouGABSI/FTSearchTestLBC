//
//  NetworkError.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case invalidURL
    case unauthorized
    case encodingFailed
    case invalidResponse
    case badRequest(String)
    case invalidData
    case requestFailed(Error)
    case decodingFailed(Error)
    case serverError(statusCode: Int, message: String)
    case unknown(Error?)
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
            case (.badRequest(let message1), .badRequest(let message2)):
                return message1 == message2
            case (.encodingFailed, .encodingFailed):
                return true
            case (.invalidData, .invalidData):
                return true
            case (.invalidResponse, .invalidResponse):
                return true
            case (.requestFailed(let error1), .requestFailed(let error2)):
                return "\(error1)" == "\(error2)"
            case (.decodingFailed(let error1), .decodingFailed(let error2)):
                return "\(error1)" == "\(error2)"
            case (.serverError(let statusCode1, let message1), .serverError(let statusCode2, let message2)):
                return statusCode1 == statusCode2 && message1 == message2
            case (.unauthorized, .unauthorized):
                return true
            case (.unknown(let error1), .unknown(let error2)):
                return "\(String(describing: error1))" == "\(String(describing: error2))"
            default:
                return false
        }
    }
}
