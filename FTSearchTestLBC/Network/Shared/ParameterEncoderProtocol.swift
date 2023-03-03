//
//  ParameterEncoderProtocol.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
     func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
