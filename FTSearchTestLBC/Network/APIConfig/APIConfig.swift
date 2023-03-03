//
//  APIConfig.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation
public class APIConfig {
    
    public static let shared = APIConfig()
    let plist = Bundle.main.infoDictionary
    private let env = Bundle.main.infoDictionary!["ENVIRONMENT"] as! String
    
    enum Environment: String {
        case dev = "DEV"
        case prod = "PROD"
    }
    
    enum LogLevel: Int {
        case none, normal, verbose
    }
    
    enum Scheme: String {
        case http = "http://"
        case https = "https://"
    }
    
    /// If one wants all the logs , set logLevel to .verbose
    var logLevel: LogLevel {
        if environment == .prod {
            return .none
        } else {
            return .verbose
        }
    }
    
    var environment: Environment {
        let result = Environment(rawValue: env)!
        return result
    }
    
    var scheme: Scheme {
        switch environment {
        case .dev:
            return .https
        case .prod:
            return .https
        }
    }
    
    
    var baseUrl: String {
        
        return "raw.githubusercontent.com"
        
    }
    
}
