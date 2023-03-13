//
//  AnnouncementAPIRequest.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation

struct AnnouncementAPIRequest: Requestable {
    var urlString: String {
         return APIConfig.shared.scheme.rawValue + APIConfig.shared.baseUrl
    }
    
    var baseURL: URL? {
        guard let url = URL(string: urlString) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String? {
        return "/leboncoin/paperclip/master/listing.json"
    }
    
    var method: HttpMethod? {
        return .get
    }
    
    var parameters: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var encoder: ParameterEncoder? {
        return JSONParameterEncoder()
    }
    
    var retryPolicy: RetryPolicy {
        return DefaultRetryPolicy()
    }
}

struct DefaultRetryPolicy: RetryPolicy {
    var maxRetries: Int {
        return 3
    }
    
    var retryInterval: TimeInterval {
        return 0.5
    }
}
