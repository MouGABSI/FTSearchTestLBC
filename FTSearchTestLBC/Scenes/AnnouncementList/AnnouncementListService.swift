//
//  AnnouncementListService.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation

protocol AnnouncementListServiceProtocol {
    func fetchAnnouncementList(completion: @escaping (Result<[Announcement], NetworkError>) -> Void)
    func fetchCategories(completion: @escaping (Result<[LBCCategory], NetworkError>) -> Void)
}

struct AnnouncementListAPIService: AnnouncementListServiceProtocol {
    func fetchAnnouncementList(completion: @escaping (Result<[Announcement], NetworkError>) -> Void) {
        NetworkSession<AnnouncementAPIRequest>().sendRequest(AnnouncementAPIRequest(), completion: completion)
    }
    
    func fetchCategories(completion: @escaping (Result<[LBCCategory], NetworkError>) -> Void) {
        NetworkSession<LBCCategoriesAPIRequest>().sendRequest(LBCCategoriesAPIRequest(), completion: completion)
    }
    
}
