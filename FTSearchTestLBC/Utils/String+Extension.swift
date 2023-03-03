//
//  String+Extension.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation
extension String {
    
    var toDate : Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+SSSS"
        return formatter.date(from: self)
    }
}
