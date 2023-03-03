//
//  LBCCategory.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation
protocol Filtrable {
    var description : String { get }
}

struct LBCCategory: Codable, Equatable, Filtrable {
    let id: Int
    let name: String
    
    var description: String {
        return name
    }
}
