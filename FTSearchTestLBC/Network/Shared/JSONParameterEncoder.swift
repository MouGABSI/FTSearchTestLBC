//
//  JSONParameterEncoder.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation
public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            if !parameters.isEmpty {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            }
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
